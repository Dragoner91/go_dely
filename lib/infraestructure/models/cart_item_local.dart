

import 'package:go_dely/domain/product_abstract.dart';

class CartLocal {
  final String id;
  final String name;
  final String description;
  final List<String> categories;
  final double price;
  final String currency;
  final String image;
  final String type;
  final double discount;
  final int quantity;

  CartLocal({
    required this.id,
    required this.name,
    required this.description,
    required this.categories,
    required this.price,
    required this.currency,
    required this.image,
    required this.quantity,
    required this.type,
    required this.discount
  });

  factory CartLocal.fromEntity(ProductAbstract item, int quantity, String image, String type) => CartLocal(
    id: item.id,
    name: item.name,
    description: item.description,
    categories: item.categories,
    price: item.price,
    currency: item.currency,
    image: image,
    quantity: quantity,
    type: type,
    discount: item.discount
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'category': categories,
    'price': price,
    'currency': currency,
    'image': image,
    'quantity': quantity,
    'type': type,
  };
}