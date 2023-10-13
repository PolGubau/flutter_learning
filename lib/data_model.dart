class Product {
  // Props
  int id;
  String name;
  String image;
  double price;
  String get imageUrl =>
      "https://firtman.github.io/coffeemasters/api/images/$image";

// Const
  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  // Add this in class Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] as int,
        name: json['name'] as String,
        price: json['price'] as double,
        image: json['image'] as String);
  }
}

class Category {
  String name;
  List<Product> products;
  Category({required this.name, required this.products});
  // Add this in class Category
  factory Category.fromJson(Map<String, dynamic> json) {
    var productsJson = json['products'] as Iterable<dynamic>;
    var products = productsJson.map((p) => Product.fromJson(p)).toList();
    return Category(name: json['name'] as String, products: products);
  }
}

class ItemsInCart {
  Product product;
  int quantity;
  ItemsInCart({required this.product, required this.quantity});
}
