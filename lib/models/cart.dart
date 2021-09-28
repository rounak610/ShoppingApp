import 'package:shopping_app/models/catalog.dart';

class CartModel{

  static final cartModel = CartModel._internal();
  CartModel._internal();
  factory CartModel() => cartModel;

  late CatalogModel _catalog;

  final List<int> _itemsIds = [];
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    assert( newCatalog!=null );
    _catalog = newCatalog;
  }

  List<Item> get items => _itemsIds.map((id) => _catalog.getById(id)).toList();

  num get totalPrice => items.fold(0, (total, current) => total + current.price);

  void add(Item item ) {
    _itemsIds.add(item.id);
  }

  void remove(Item item ) {
    _itemsIds.remove(item.id);
  }
}

