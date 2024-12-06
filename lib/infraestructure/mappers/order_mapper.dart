import 'package:go_dely/domain/order/order.dart';
import 'package:go_dely/infraestructure/models/order_db.dart';

class OrderMapper {

  static Order orderToEntity(OrderDB orderDB) =>
    Order(
      address: orderDB.address, 
      combos: orderDB.combos, 
      currency: orderDB.currency, 
      paymentMethod: orderDB.paymentMethod, 
      products: orderDB.products, 
      total: orderDB.total
    );
}