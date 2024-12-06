import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/domain/product/product.dart';

class Order {
  final String address;
  final String paymentMethod;
  final String currency;
  final double total;
  final List<Product> products;
  final List<Combo> combos;

  Order({
    required this.address, 
    required this.combos,
    required this.currency,
    required this.paymentMethod,
    required this.products,
    required this.total
    });
}