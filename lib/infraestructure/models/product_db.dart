

class ProductDB {
  final String id;
  final String name;
  final double price;
  final String currency;
  final String weight;
  final List<String> imageUrl;
  final String description;
  final int stock;
  final List<String> categories;
  final String discount; 
  final String measurement;

  ProductDB({
    required this.id, 
    required this.name, 
    required this.price, 
    required this.currency, 
    required this.weight, 
    required this.imageUrl, 
    required this.description, 
    required this.stock,
    required this.categories,
    required this.discount,
    required this.measurement
    });

  factory ProductDB.fromJson(Map<String, dynamic> json) { 
    try {
      return ProductDB(
          id: json["id"], 
          name: json["name"], 
          price: json["price"] is String ? double.parse(json["price"]) : json["price"].toDouble(),
          currency: json["currency"], 
          weight: json["weight"].toString(), 
          measurement: json['measurement'],
          imageUrl: json["images"] != null
            ? List<String>.from(json["images"].map((e) => e))
            : [],
          description: json["description"], 
          stock: json["stock"] is String ? double.parse(json["stock"]).toInt() : json["stock"].toInt(),
          categories: List<String>.from(json["categories"].map((e) => e)),
          discount: json["discount"] ?? "No Discount",
      );
    } catch (e) {
      print(e);
    }
    return ProductDB(
      id: json["id"], 
          name: json["name"], 
          price: json["price"] is String ? double.parse(json["price"]) : json["price"].toDouble(),
          currency: json["currency"], 
          weight: json["weight"].toString(), 
          measurement: json['measurement'],
          imageUrl: json["images"] != null
            ? List<String>.from(json["images"].map((e) => e))
            : [],
          description: json["description"], 
          stock: json["stock"] is String ? double.parse(json["stock"]).toInt() : json["stock"].toInt(),
          categories: List<String>.from(json["categories"].map((e) => e)),
          discount: json["discount"] == null ? 0.0 : (json["discount"] is String ? double.tryParse(json["discount"]) ?? 0.1 : json["discount"].toDouble()),
  );
  }

  Map<String, dynamic> toJson() => {
    "product_id": id,
    "product_name": name,
    "product_price": price,
    "product_currency": currency,
    "product_weight": weight,
    "product_image": List<String>.from(imageUrl.map((e) => e,)),
    "product_description": description,
    "product_stock": stock,
    "product_category": categories,
    "product_discount": discount
  };
}