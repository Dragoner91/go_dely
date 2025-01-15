import 'package:go_dely/domain/order/order.dart';
import 'package:go_dely/infraestructure/models/order_db.dart';

class OrderMapper {

    static Order orderToEntity(OrderDB orderDB) =>
    Order(
      id: orderDB.id,
      address: orderDB.address,  
      currency: orderDB.currency,  
      paymentMethod: orderDB.paymentMethod, 
      items: orderDB.items,
      total: orderDB.total,
      status: orderDB.status, 
      uuid: orderDB.uuid, 
      latitude: orderDB.latitude, 
      longitude: orderDB.longitude
    );
}