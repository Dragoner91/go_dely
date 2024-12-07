import 'package:go_dely/domain/cart/i_cart.dart';
import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/domain/product/product.dart';
import 'package:go_dely/domain/product_abstract.dart';
import 'package:go_dely/infraestructure/mappers/cart_item_mapper.dart';
import 'package:go_dely/infraestructure/mappers/combo_mapper.dart';
import 'package:go_dely/infraestructure/mappers/product_mapper.dart';
import 'package:go_dely/infraestructure/models/cart_item_local.dart';
import 'package:go_dely/infraestructure/models/combo_db.dart';
import 'package:go_dely/infraestructure/models/product_db.dart';

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
  final List<ICart> items;

  OrderDB({
    required this.id,
    required this.address, 
    required this.paymentMethod, 
    required this.currency, 
    required this.total, 
    required this.items, 
    required this.status
  });

  factory OrderDB.fromJson(Map<String, dynamic> json) {
    List<ICart> items = [];
print(items);
    if (json['order_combos'] != null) {
      items.addAll((json['order_combos'] as List)
          .map((e) => CartItemMapper.cartItemToEntity(CartLocal.fromEntity( ComboMapper.comboToEntity(ComboDB.fromJson(e)) , e['quantity'], "", "Combo")))
          .toList());
    }

    if (json['order_products'] != null) {
      items.addAll((json['order_products'] as List)
          .map((e) => CartItemMapper.cartItemToEntity(CartLocal.fromEntity( ProductMapper.productToEntity(ProductDB.fromJson(e)) , e['quantity'], "", "Product")))
          .toList());
    }
    
    return OrderDB(
      id: json['order_id'],
      address: json['address'],
      items: items,
      currency: json['currency'],
      status: json['status'],
      paymentMethod: json['paymentMethodId'],
      total: json['total'] is String ? double.parse(json['total']) : json['total'].toDouble(),
    );
  }
  
  
}