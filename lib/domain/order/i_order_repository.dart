
import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/order/order.dart';

class GetOrderByIdDto {
  final String id;
  final String backSelected;

  GetOrderByIdDto({
    required this.id,
    required this.backSelected
  });
}

class GetOrdersDto {
  final int page;
  final int perPage;
  final String backSelected;

  GetOrdersDto({required this.page, required this.perPage, required this.backSelected});
  
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

  Future<Result<List<Order>>> getOrders(GetOrdersDto dto);

  Future<Result<Order>> getOrderById(GetOrderByIdDto dto);

  Future<Result<void>> changeStatus(ChangeStatusDto dto);

}