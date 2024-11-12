
import 'package:go_dely/domain/entities/product/product_abstract.dart';

// ignore_for_file: overridden_fields, annotate_overrides

class Combo extends ProductAbstract{

  final String id;
  final String name;
  final double price;
  final List<String> imageUrl;

  Combo({required this.id, required this.name, required this.price, required this.imageUrl}) :
   super(id: id, name: name, price: price, imageUrl: imageUrl);

}