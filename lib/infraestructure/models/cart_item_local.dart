

import 'package:go_dely/domain/product_abstract.dart';

class CartLocal {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final String currency;
  final String image;
  final int quantity;

  CartLocal({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.currency,
    required this.image,
    required this.quantity
  });

  factory CartLocal.fromEntity(ProductAbstract item, int quantity, String image) => CartLocal(
    id: item.id,
    name: item.name,
    description: item.description,
    category: item.category,
    price: item.price,
    currency: item.currency,
    image: image,
    quantity: quantity,
  );

  Map<String, dynamic> toJson() => {

  };
}