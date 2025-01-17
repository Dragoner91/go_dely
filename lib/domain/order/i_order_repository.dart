
import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/order/order.dart';

class GetOrderByIdDto {
  final String id;

  GetOrderByIdDto({
    required this.id
  });
}

class GetOrdersDto {
  final int page;
  final int perPage;

  GetOrdersDto({required this.page, required this.perPage});
  
}

class ChangeStatusDto {
  final String id; 
  final String status;

  ChangeStatusDto({
    required this.id,
    required this.status
  });
}

abstract class IOrderRepository {

  Future<Result<String>> createOrder(CreateOrderDto order);

  Future<Result<List<Order>>> getActiveOrders(GetOrdersDto dto);

  Future<Result<List<Order>>> getPastOrders(GetOrdersDto dto);

  Future<Result<Order>> getOrderById(GetOrderByIdDto dto);

  Future<Result<void>> changeStatus(ChangeStatusDto dto);

}