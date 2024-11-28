
import 'package:go_dely/domain/entities/product/product.dart';
import 'package:go_dely/infraestructure/mappers/product_mapper.dart';
import 'package:go_dely/infraestructure/models/product_db.dart';

class ComboDB {
  final String id;
  final String name;
  final double price;
  final String category;
  final String currency;
  final String imageUrl;
  final List<Product> products;
  final String description;
  final double discount;

  ComboDB({
    required this.id, 
    required this.name, 
    required this.price, 
    required this.description,
    required this.products, 
    required this.category,
    required this.currency,
    required this.imageUrl,
    required this.discount
  });

  factory ComboDB.fromJson(Map<String, dynamic> json) => ComboDB(
    id: json["combo_id"].toString(), 
    name: json["combo_name"], 
    price: double.parse(json["combo_price"]), 
    products: List<Product>.from(json["products"].map((e) => ProductMapper.productToEntity(ProductDB.fromJson(e)))), 
    description: json["combo_description"], 
    category: json["combo_category"],
    currency: json["combo_currency"],
    imageUrl: json["combo_image"],
    discount: json["combo_discount"] ? double.parse(json["combo_discount"]) : 0.0,
  );

  Map<String, dynamic> toJson() => {
    "combo_id": id,
    "produccombo_namet_name": name,
    "combo_price": price,
    "products": List<Product>.from(products.map((e) => e,)),
    "combo_description": description,
    "combo_category": category,
    "combo_currency": currency,
    "combo_image": imageUrl,
    "combo_discount": discount
  };
}