import 'package:isar/isar.dart';

part 'cart.g.dart';

@collection
class Cart {
  Id isarId;
  Item item;
  int quantity;

  Cart({required this.isarId , required this.item, required this.quantity});

}

@embedded
class Item{
  
  final String? id;
  final String? name;
  final String? description;
  final String? category;
  final double? price;
  final String? currency;
  final String? image;  

  Item({
    this.id, 
    this.name, 
    this.description, 
    this.price, 
    this.image, 
    this.category, 
    this.currency
  });
}