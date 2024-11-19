
import 'package:go_dely/domain/entities/product/product.dart';
import 'package:go_dely/domain/entities/product_abstract.dart';

// ignore_for_file: overridden_fields, annotate_overrides

class Combo extends ProductAbstract{

  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String currency;
  final String imageUrl;
  final List<Product> products;

  Combo({required this.id, required this.name, required this.price, required this.products, required this.description, required this.category, required this.currency, required this.imageUrl}) :
   super(id: id, name: name, price: price, description: description, category: category, currency: currency);

}