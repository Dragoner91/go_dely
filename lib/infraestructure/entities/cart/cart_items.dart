// ignore_for_file: overridden_fields, annotate_overrides

import 'package:go_dely/domain/cart/i_cart.dart';
import 'package:isar/isar.dart';

part 'cart_items.g.dart';

@collection
class CartItem extends ICart{
  Id? isarId;
  final String id;
  final String name;
  final String description;
  final List<String> categories;
  final double price;
  final String currency;
  final String image; 
  final String type;
  final String discount;
  int quantity;

  CartItem({
    this.isarId, 
    required this.quantity, 
    required this.categories, 
    required this.currency, 
    required this.description, 
    required this.id, 
    required this.image, 
    required this.name, 
    required this.price,
    required this.type,
    required this.discount
  }) : super(
    quantity: quantity, 
    categories: categories, 
    currency: currency, 
    description: description, 
    id: id, 
    image: image, 
    name: name, 
    price: price,
    type: type,
    discount: discount
  );

}

