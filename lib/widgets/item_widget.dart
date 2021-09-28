import 'package:flutter/material.dart';
import 'package:shopping_app/models/catalog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/pages/item_detailspg.dart';

class ItemWidget extends StatefulWidget {
  final Item item;

  const ItemWidget({required Key key, required this.item,})
      : assert(item != null),
        super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  @override
  bool _isFavorite = false;

  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      color: Colors.grey[700],
      child: Column(
        children:[
          ListTile(
            dense: true,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDetail(
                item: widget.item,
                key: ValueKey(CatalogModel.items),
              )
              )
              );
            },
            leading: Container(
                width: 70,
                height: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(widget.item.image)
                    )
                )
            ),
            title: Text(widget.item.title,
              style: GoogleFonts.robotoMono(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
            //subtitle: Text(item.description),
            trailing: Text(
              "\$${widget.item.price}",
              style: GoogleFonts.robotoMono(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: Colors.lightGreenAccent[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: IconButton(
              iconSize: 35,
              icon: (_isFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border_outlined)),
              color: Colors.red[500],
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
            )
          ),
        ]
      ),
    );
  }
}