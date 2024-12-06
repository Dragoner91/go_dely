import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/order/i_order_repository.dart';
import 'package:go_dely/domain/order/order.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';
import 'package:go_dely/infraestructure/datasources/petitions/i_petition.dart';
import 'package:go_dely/infraestructure/mappers/order_mapper.dart';
import 'package:go_dely/infraestructure/models/order_db.dart';

class OrderRepositoryImpl extends IOrderRepository{

  final IPetition petition;
  final IAuthRepository auth;

  OrderRepositoryImpl({required this.petition, required this.auth});

  @override
  Future<Result<String>> createOrder(Order order) async {

    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    var queryParameters = {
      'user_id': tokenResult.unwrap(), //*VERIFICAR
      'address': order.address,
      'paymentMethodId': order.paymentMethod,
      'currency': order.currency,
      'total': order.total,
      //*lista de productos
      //*lista de combos
    };

    final result = await petition.makeRequest(
      urlPath: '/orders/create',
      httpMethod: 'POST',
      mapperCallBack: (data) {
        final String orderId = data['']; //*TERMINAR
        return orderId;
      },
      body: queryParameters
    );
    return result;
  }

  @override
  Future<Result<Order>> getOrderById(String id) async {

    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    var queryParameters = {
      'token': tokenResult.unwrap(), //*VERIFICAR
    };

    final result = await petition.makeRequest(
      urlPath: '/orders/$id',
      httpMethod: 'GET',
      mapperCallBack: (data) {
          final Order order = OrderMapper.orderToEntity(
          OrderDB.fromJson(data)
        );
        return order;
      },
      body: queryParameters
    );
    return result;
  }

  @override
  Future<Result<List<Order>>> getOrders() async {

    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    var queryParameters = {
      'token': tokenResult.unwrap(), //*VERIFICAR
    };

    final result = await petition.makeRequest(
      urlPath: '/orders',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Order> orders = [];
        for (var order in data) {
          orders.add(
            OrderMapper.orderToEntity(
              OrderDB.fromJson(order)
            )
          );
        }
        return orders;
      },
      body: queryParameters
    );
    return result;
  }


}