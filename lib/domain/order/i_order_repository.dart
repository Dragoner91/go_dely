
import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/order/order.dart';

abstract class IOrderRepository {

  Future<Result<void>> createOrder(Order order);

  Future<Result<List<Order>>> getOrders();

  Future<Result<Order>> getOrderById(String id);

}