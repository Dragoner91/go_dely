// ignore_for_file: overridden_fields, annotate_overrides

import 'package:go_dely/domain/entities/cart/i_cart.dart';
import 'package:isar/isar.dart';

part 'cart_items.g.dart';

@collection
class CartItem extends ICart{
  Id? isarId;
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final String currency;
  final String image; 
  int quantity;

  CartItem({
    this.isarId, 
    required this.quantity, 
    required this.category, 
    required this.currency, 
    required this.description, 
    required this.id, 
    required this.image, 
    required this.name, 
    required this.price
  }) : super(
    quantity: quantity, 
    category: category, 
    currency: currency, 
    description: description, 
    id: id, 
    image: image, 
    name: name, 
    price: price
  );

}

