import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/models/cart.dart';
import 'package:shopping_app/models/catalog.dart';
import 'package:shopping_app/pages/cart_pg.dart';
import 'package:shopping_app/widgets/item_widget.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override

  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final _cart =CartModel();
  Color _iconColor = Colors.white;
  @override

  void initState() {
    super.initState();
    loadData();
  }

  loadData() async{
    await Future.delayed(Duration(milliseconds: 10));
    final catalogJason = await rootBundle.loadString('assets/files/sample_products.json');
    final decodeData = jsonDecode(catalogJason);
    var productsData = decodeData["products"];
    CatalogModel.items = List.from(productsData).map<Item>((item) => Item.fromMap(item)).toList();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xffFFA8A8), const Color(0xff5961F9)],
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: Container(),
            actions: [
              IconButton(
                icon: Icon(Icons.shopping_cart_rounded),
                color: _iconColor,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
                  setState(() {
                    _iconColor = Colors.redAccent;
                  });
                },
              ),
            ],
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
          ),
          body: (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
              ? ListView.builder(
                       itemCount: CatalogModel.items.length,
                       itemBuilder: (context, index) => ItemWidget(
                             item: CatalogModel.items[index],
                           key: ValueKey(CatalogModel.items[index].id)
            ),
          )
              : Center(
                    child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
void main()
{
  final _cart =CartModel();
  print(_cart.items.length);
}

