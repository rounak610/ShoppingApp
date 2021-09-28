import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/models/cart.dart';
import 'package:shopping_app/models/catalog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/pages/cart_pg.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:badges/badges.dart';

class ItemDetail extends StatefulWidget {
  final Item item;
  
  const ItemDetail({required Key key, required this.item,})
      : assert(item != null),
        super(key: key);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  final _cart =CartModel();
  Color _iconColor = Colors.white;
  bool isAdded = false;

  @override

  Widget build(BuildContext context) {
    int count = _cart.items.length;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xff3EADCF), const Color(0xffABE9CD)],
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
          title: Text(
          'Products',
          style: GoogleFonts.robotoMono(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
          ),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                child: Badge(
                  //animationType: BadgeAnimationType.scale,
                  badgeContent: Text(count.toString(),
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  badgeColor: Colors.redAccent,
                  child: IconButton(
                    icon: Icon(Icons.shopping_cart_rounded),
                    color: _iconColor,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
                       setState(() {
                         _iconColor = Colors.black;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(widget.item.title,
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(widget.item.image)
                          )
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Category: '+widget.item.category,
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 20,
                        color: Colors.black
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.item.description,
                      style: GoogleFonts.robotoMono(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 15,
                        color: Colors.black
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Text("\$${widget.item.price}",
                      style: GoogleFonts.robotoMono(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 25,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(130, 20, 5, 20),
                        child: ElevatedButton(onPressed: () {
                          final _cart =CartModel();
                          bool isInCart = _cart.items.contains(widget.item);
                          if(!isInCart){
                            isAdded = isAdded.toggle();
                            final _catalog = CatalogModel();
                            // final _cart = CartModel();
                            _cart.catalog = _catalog;
                            _cart.add(widget.item);
                            setState(() {});
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Item Added'),
                              duration: Duration(milliseconds: 200),
                            ),
                            );
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Item already present in the cart'),
                              duration: Duration(milliseconds: 500),
                            ),
                            );
                          }
                        },
                          child:Text(
                            'Add to cart',
                            style: GoogleFonts.robotoMono(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states)
                              {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.deepOrange;
                                return Colors.black;
                              }
                              ),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    )
                                )
                        )
                    ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

