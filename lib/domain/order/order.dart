
import 'package:go_dely/domain/cart/i_cart.dart';
import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/domain/product/product.dart';

class CreateOrder {
  final String id;
  final String address;
  final String paymentMethod;
  final String currency;
  final String status;
  final double total;
  final List<Map<String, dynamic>> products;
  final List<Map<String, dynamic>> combos;

  CreateOrder({
    required this.id,
    required this.address, 
    required this.combos,
    required this.currency,
    required this.paymentMethod,
    required this.products,
    required this.total,
    required this.status
    });
}

class Order {
  final String id;
  final String address;
  final String paymentMethod;
  final String currency;
  final String status;
  final double total;
  final List<ICart> items;

  Order({
    required this.id,
    required this.address, 
    required this.currency,
    required this.paymentMethod,
    required this.items,
    required this.total,
    required this.status
    });
}