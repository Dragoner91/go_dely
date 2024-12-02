

class ProductDB {
  final String id;
  final String name;
  final double price;
  final String currency;
  final String weight;
  final List<String> imageUrl;
  final String description;
  final int stock;
  final String category;
  final double discount; 

  ProductDB({
    required this.id, 
    required this.name, 
    required this.price, 
    required this.currency, 
    required this.weight, 
    required this.imageUrl, 
    required this.description, 
    required this.stock,
    required this.category,
    required this.discount
    });

  factory ProductDB.fromJson(Map<String, dynamic> json) => ProductDB(
    id: json["product_id"], 
    name: json["product_name"], 
    price: double.parse(json["product_price"]), 
    currency: json["product_currency"], 
    weight: json["product_weight"], 
    imageUrl: List<String>.from(json["images"].map((e) => e)), 
    description: json["product_description"], 
    stock: json["product_stock"],
    category: json["product_category"],
    discount: json["discount"] == null ? 0.0 : double.tryParse(json["discount"]["value"]) ?? 0.1,
  );

  Map<String, dynamic> toJson() => {
    "product_id": id,
    "product_name": name,
    "product_price": price,
    "product_currency": currency,
    "product_weight": weight,
    "product_image": List<String>.from(imageUrl.map((e) => e,)),
    "product_description": description,
    "product_stock": stock,
    "product_category": category,
    "product_discount": discount
  };
}