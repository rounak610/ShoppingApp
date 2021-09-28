class CatalogModel
{
  static final catModel = CatalogModel._internal();
  CatalogModel._internal();
  factory CatalogModel() => catModel;

  static List<Item> items =
  [
    Item
      (
        id: 1,
        title: "iPhone 12 Pro",
        description: "Apple iPhone 12th generation",
        price: 999,
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRISJ6msIu4AU9_M9ZnJVQVFmfuhfyJjEtbUm3ZK11_8IV9TV25-1uM5wHjiFNwKy99w0mR5Hk&usqp=CAc",
        category: "Electronics"
      )
  ];

  // Get Item by ID
  Item getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  Item getByPosition(int pos) => items[pos];
}

class Item
{
  final int id;
  final String title;
  final String description;
  final num price;
  final String image;
  final String category;

  Item({required this.id, required this.title, required this.description, required this.price, required this.image, required this.category});

  factory Item.fromMap(Map<String, dynamic>Map) {
    return Item(
      id: Map["id"],
      title: Map["title"],
      description: Map["description"],
      price: Map["price"],
      image: Map["image"],
      category: Map["category"],
    );
  }

  toMap() => {
    "id" : id,
    "title" : title,
    "description" : description,
    "price" : price,
    "image" : image,
    "category" : category
  };
}
