
import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/order/order.dart';

abstract class IOrderRepository {

  Future<Result<String>> createOrder(Order order);

  Future<Result<List<Order>>> getOrders();

  Future<Result<Order>> getOrderById(String id);

  Future<Result<void>> changeStatus(String id, String status);

}