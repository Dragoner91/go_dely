
import 'package:go_dely/domain/product_abstract.dart';

// ignore_for_file: overridden_fields, annotate_overrides

class Combo extends ProductAbstract{

  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> categories;
  final String currency;
  final List<String> imageUrl;
  final String discount; 
  final List<String> products;

  Combo({required this.id, required this.name, required this.price, required this.products, required this.description, required this.categories, required this.currency, required this.imageUrl, required this.discount}) :
   super(id: id, name: name, price: price, description: description, categories: categories, currency: currency, discount: discount);

}