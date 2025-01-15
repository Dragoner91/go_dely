
import 'package:get_it/get_it.dart';
import 'package:go_dely/domain/product/i_product_repository.dart';
import 'package:go_dely/domain/product/product.dart';

class ComboDB {
  final String id;
  final String name;
  final double price;
  final List<String> categories;
  final String currency;
  final List<String> imageUrl;
  final List<String> products;
  final String description;
  final String discount;
  
  ComboDB({
    required this.id, 
    required this.name, 
    required this.price, 
    required this.description,
    required this.products, 
    required this.categories,
    required this.currency,
    required this.imageUrl,
    required this.discount
  });

  static ComboDB fromJson(Map<String, dynamic> json) {
    print(json['category']);
    return ComboDB(
      id: json["id"], 
      name: json["name"], 
      price: json["price"] is String ? double.parse(json["price"]) : json["price"].toDouble(),
      products: List<String>.from(json["productId"].map((e) => e)),
      description: json["description"], 
      categories: List<String>.from(json["category"].map((e) => e)),
      currency: json["currency"],
      imageUrl: List<String>.from(json["images"].map((e) => e)),
      discount: json['discount'] ?? "No Discount",
    );
  }

  Map<String, dynamic> toJson() => {
    "combo_id": id,
    "produccombo_namet_name": name,
    "combo_price": price,
    "products": List<Product>.from(products.map((e) => e,)),
    "combo_description": description,
    "combo_category": categories,
    "combo_currency": currency,
    "combo_image": imageUrl,
    "combo_discount": discount
  };
}