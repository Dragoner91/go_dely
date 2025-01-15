
import 'package:go_dely/domain/cart/i_cart.dart';

class CreateOrderDto {
  final String address;
  final String latitude;
  final String longitude;
  final String paymentMethod;
  final String currency;
  final String status;
  final double total;
  final String? couponCode;
  final List<Map<String, dynamic>> products;
  final List<Map<String, dynamic>> combos;

  CreateOrderDto({
    required this.address, 
    required this.latitude,
    required this.longitude,
    required this.combos,
    required this.currency,
    required this.paymentMethod,
    required this.products,
    this.couponCode,
    required this.total,
    required this.status
    });
}

class Order {
  final String uuid;
  final String id;
  final String address;
  final String latitude;
  final String longitude;
  final String paymentMethod;
  final String currency;
  final String status;
  final double total;
  final List<ICart> items;

  Order({
    required this.uuid,
    required this.id,
    required this.address, 
    required this.latitude,
    required this.longitude,
    required this.currency,
    required this.paymentMethod,
    required this.items,
    required this.total,
    required this.status
    });
}