import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/domain/product/product.dart';

class OrderDB {
  final String address;
  final String paymentMethod;
  final String currency;
  final double total;
  final List<Product> products;
  final List<Combo> combos;

  OrderDB({
    required this.address, 
    required this.paymentMethod, 
    required this.currency, 
    required this.total, 
    required this.products, 
    required this.combos
  });

  factory OrderDB.fromJson(Map<String, dynamic> json) => OrderDB(
    address: json['address'],
    combos: json[''],  //*TERMINAR
    currency: json['currency'],
    paymentMethod: json['paymentMethodId'],
    products: json[''],  //*TERMINAR
    total: json['total'],
  );
  
  
}