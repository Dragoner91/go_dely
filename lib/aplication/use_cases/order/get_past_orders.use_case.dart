import 'package:go_dely/core/result.dart';
import 'package:go_dely/core/use_case.dart';
import 'package:go_dely/domain/order/i_order_repository.dart';
import 'package:go_dely/domain/order/order.dart';

class GetPastOrdersUseCase extends IUseCase<GetOrdersDto, List<Order>> {
  final IOrderRepository orderRepository;

  GetPastOrdersUseCase(this.orderRepository);

  @override
  Future<Result<List<Order>>> execute(GetOrdersDto dto) async {
    return await orderRepository.getPastOrders(dto);
  }
}