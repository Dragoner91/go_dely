

import 'package:go_dely/core/result.dart';
import 'package:go_dely/core/use_case.dart';
import 'package:go_dely/domain/order/i_order_repository.dart';
import 'package:go_dely/domain/order/order.dart';

class CreateOrderUseCase extends IUseCase<CreateOrderDto, String> {

  final IOrderRepository orderRepository;

  CreateOrderUseCase(this.orderRepository);
  
  @override
  Future<Result<String>> execute(CreateOrderDto dto) async {
    return await orderRepository.createOrder(dto);
  }

}