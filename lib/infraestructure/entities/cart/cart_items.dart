import 'package:isar/isar.dart';

part 'cart_items.g.dart';

@collection
class CartItem {
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
  });

}

