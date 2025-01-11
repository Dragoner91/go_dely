import 'package:go_dely/domain/order/order.dart';
import 'package:go_dely/infraestructure/models/order_db.dart';

class OrderMapper {

  static CreateOrderDto createOrderToEntity(OrderDB orderDB) =>
    CreateOrderDto(
      id: orderDB.id,
      address: orderDB.address, 
      combos:  [{}], //orderDB.combos, 
      currency: orderDB.currency,  //*ARREGLAR ESTO
      paymentMethod: orderDB.paymentMethod, 
      products: [{}], //orderDB.products, 
      total: orderDB.total,
      status: orderDB.status
    );

    static Order orderToEntity(OrderDB orderDB) =>
    Order(
      id: orderDB.id,
      address: orderDB.address,  //orderDB.combos, 
      currency: orderDB.currency,  //*ARREGLAR ESTO
      paymentMethod: orderDB.paymentMethod, 
      items: orderDB.items, //orderDB.products, 
      total: orderDB.total,
      status: orderDB.status
    );
}