import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/models/cart.dart';
import 'package:shopping_app/pages/catalog_pg.dart';
import 'package:velocity_x/velocity_x.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xff9FA4C4), const Color(0xff1D6FA3)],
                )
            ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(CupertinoIcons.back),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CatalogPage()));
                },
              ),
              title: Text(
                'Cart',
                    style: GoogleFonts.robotoMono(
                   textStyle: Theme.of(context).textTheme.headline4,
                   fontSize: 25,
                   fontWeight: FontWeight.bold,
                   color: Colors.white
              ),
            ),
                   centerTitle: true,
          ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                 _CartList(),
                ],
              )
            ),
        )
    )
    );
  }
}

class _CartTotal extends StatefulWidget {
  const _CartTotal({Key? key}) : super(key: key);

  @override
  __CartTotalState createState() => __CartTotalState();
}

class __CartTotalState extends State<_CartTotal> {

  @override
  final _cart =CartModel();
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("\$"+_cart.totalPrice.toStringAsFixed(2),
                style: GoogleFonts.robotoMono(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[400]
                )
            ),
            30.widthBox,
            ElevatedButton(onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Buying not supported yet!!'),
                duration: Duration(seconds: 1),
              ),
              );
            },
              child: Text(
                'Place Order',
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
            ),
            )
          ],
        ),
        SizedBox(
          height: 40.0,
        )
      ],
    );
  }
}

class _CartList extends StatefulWidget {
  const _CartList({Key? key}) : super(key: key);

  @override
  __CartListState createState() => __CartListState();
}

class __CartListState extends State<_CartList> {
  final _cart =CartModel();
  int _itemCount=0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
         _cart.items.isEmpty? "No items present in cart".text.xl3.white.bold.makeCentered() : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _cart.items.length,
              itemBuilder: (context,index) =>
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.done_outline_rounded,
                          color: Colors.black,
                          size: 30,),
                          subtitle: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(80,10,5, 10),
                                child: IconButton(
                                    icon: Icon(CupertinoIcons.cart_badge_plus),
                                    iconSize: 30,
                                    onPressed: () {
                                      _cart.add(_cart.items[index]);
                                      setState(() {});
                                    }
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 10, 50, 10),
                                child: IconButton(
                                    icon: Icon(CupertinoIcons.cart_badge_minus),
                                    iconSize: 30,
                                    onPressed: () {
                                      _cart.remove(_cart.items[index]);
                                      setState(() {});
                                    }
                                ),
                              ),
                            ],
                          ),
                          title: _cart.items[index].title.text.xl.bold.black.make(),
                        ),
                      ],
                    ),
                  )
          ),
          _CartTotal()
        ],
      ),
    );
  }
}


