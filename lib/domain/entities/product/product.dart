
// ignore_for_file: overridden_fields, annotate_overrides

import 'package:go_dely/domain/entities/product_abstract.dart';

class Product extends ProductAbstract{
  
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

  Product({
    required this.id, 
    required this.name, 
    required this.price, 
    required this.description, 
    required this.imageUrl, 
    required this.weight, 
    required this.currency,
    required this.stock, 
    required this.category,
    required this.discount
    }) : super(
    id: id, 
    name: name, 
    price: price,
    description: description,
    category: category,
    currency: currency,
    discount: discount
  );

}