

import 'package:go_dely/core/result.dart';
import 'package:go_dely/core/use_case.dart';
import 'package:go_dely/domain/order/i_order_repository.dart';
import 'package:go_dely/domain/order/order.dart';

class CreateOrderUseCase extends IUseCase<CreateOrderDto, Order> {

  final IOrderRepository orderRepository;

  CreateOrderUseCase(this.orderRepository);
  
  @override
  Future<Result<Order>> execute(CreateOrderDto dto) {
    // TODO: implement execute
    throw UnimplementedError();
  }

}