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
  Future<Result<String>> createOrder(CreateOrderDto order) async {  //*CAMBIAR A CreateOrderDto

    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");
    var queryParameters = {
      'address': order.address,
      'paymentMethodId': order.paymentMethod,
      'currency': order.currency,
      'total': order.total,
      'order_products': order.products,
      'order_combos': order.combos
    };

    print(queryParameters);

    final result = await petition.makeRequest(
      urlPath: '/orders/create',
      httpMethod: 'POST',
      mapperCallBack: (data) {
        final String orderId = data['order_id']; //*TERMINAR
        return orderId;
      },
      body: queryParameters
    );
    return result;
  }

  @override
  Future<Result<Order>> getOrderById(GetOrderByIdDto dto) async {  //* CAMBIAR A GetOrderByIdDto

    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");

    final result = await petition.makeRequest(
      urlPath: '/orders/${dto.id}',
      httpMethod: 'GET',
      mapperCallBack: (data) {
          final Order order = OrderMapper.orderToEntity(
          OrderDB.fromJson(data)
        );
        return order;
      },
    );
    return result;
  }

  @override
  Future<Result<List<Order>>> getOrders(GetOrdersDto dto) async {

    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");

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
    );
    return result;
  }

  @override
  Future<Result<void>> changeStatus(ChangeStatusDto dto) async {  
    
    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");

    var queryParameters = {
      'status': dto.status,
    };

    final result = await petition.makeRequest(
      urlPath: '/orders/${dto.id}/status',
      httpMethod: 'PATCH',
      mapperCallBack: (data) {
        return data['message'];
      },
      body: queryParameters
    );
    
    return result;

  }

}