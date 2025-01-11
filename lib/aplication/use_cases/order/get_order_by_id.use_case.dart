
import 'package:go_dely/core/result.dart';
import 'package:go_dely/core/use_case.dart';
import 'package:go_dely/domain/order/i_order_repository.dart';
import 'package:go_dely/domain/order/order.dart';

class GetOrderByIdUseCase extends IUseCase<GetOrderByIdDto, Order> {
  final IOrderRepository orderRepository;

  GetOrderByIdUseCase(this.orderRepository);

  @override
  Future<Result<Order>> execute(GetOrderByIdDto dto) async {
    return await orderRepository.getOrderById(dto);
  }

}

