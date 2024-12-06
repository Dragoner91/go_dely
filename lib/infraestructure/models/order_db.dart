import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/domain/product/product.dart';

class CreateOrderDB {
  final String id;
  final String address;
  final String paymentMethod;
  final String currency;
  final String status;
  final double total;
  final List<String> products;
  final List<String> combos;

  CreateOrderDB({
    required this.id,
    required this.address, 
    required this.paymentMethod, 
    required this.currency, 
    required this.total, 
    required this.products, 
    required this.combos,
    required this.status
  });

  factory CreateOrderDB.fromJson(Map<String, dynamic> json) => CreateOrderDB(
    id: json['order_id'],
    address: json['address'],
    combos: [], //json[''],  //*TERMINAR
    currency: json['currency'],
    status: json['status'],
    paymentMethod: json['paymentMethodId'],
    products: [], //json[''],  //*TERMINAR
    total: json['total'],
  );
  
  
}

class OrderDB {
  final String id;
  final String address;
  final String paymentMethod;
  final String currency;
  final String status;
  final double total;
  final List<Product> products;
  final List<Combo> combos;

  OrderDB({
    required this.id,
    required this.address, 
    required this.paymentMethod, 
    required this.currency, 
    required this.total, 
    required this.products, 
    required this.combos,
    required this.status
  });

  factory OrderDB.fromJson(Map<String, dynamic> json) => OrderDB(
    id: json['order_id'],
    address: json['address'],
    combos: [], //json[''],  //*TERMINAR
    currency: json['currency'],
    status: json['status'],
    paymentMethod: json['paymentMethodId'],
    products: [], //json[''],  //*TERMINAR
    total: json['total'] is String ? double.parse(json['total']) : json['total'].toDouble(),
  );
  
  
}