import 'package:go_dely/domain/cart/i_cart.dart';
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

  OrderDB({
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

  factory OrderDB.fromJson(Map<String, dynamic> json) {
    List<ICart> items = [];
    
    if (json['combos'] != null) {
      items.addAll((json['combos'] as List)
          .map((e) => CartItemMapper.cartItemToEntity(CartLocal.fromEntity( ComboMapper.comboToEntity(ComboDB.fromJson(e)) , e['quantity'], e['images'][0], "Combo")))
          .toList());
    }

    if (json['products'] != null) {
      items.addAll((json['products'] as List)
          .map((e) => CartItemMapper.cartItemToEntity(CartLocal.fromEntity( ProductMapper.productToEntity(ProductDB.fromJson(e)) , e['quantity'], e['images'][0], "Product")))
          .toList());
    }
    
    return OrderDB(
      id: json['incremental_id'].toString(),
      address: json['address'],
      items: items,
      currency: json['currency'] ?? json['paymentMethod']['currency'],
      status: json['status'],
      paymentMethod: json['paymentMethod'] ?? json['paymentMethod']['paymentMethod'],
      total: json['total'] is String ? double.parse(json['total']) : json['total'].toDouble() ?? json['paymentMethod']['total'], 
      uuid: json['id'], 
      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString(),
    );
  }
  
  
}