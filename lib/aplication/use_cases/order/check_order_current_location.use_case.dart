

import 'package:go_dely/core/result.dart';
import 'package:go_dely/core/use_case.dart';
import 'package:go_dely/domain/order/i_order_repository.dart';

class GetLocationDto {
  final String orderId;
  final String currentLatitude;
  final String currentLongitude;

  GetLocationDto({required this.orderId, required this.currentLatitude, required this.currentLongitude});
}

class CheckOrderCurrentLocationUseCase extends IUseCase<GetLocationDto, String> { //* CAMBIAR ESO DE STRING PARA CUANDO ESTE LISTO

  final IOrderRepository orderRepository;

  CheckOrderCurrentLocationUseCase(this.orderRepository);

  @override
  Future<Result<String>> execute(GetLocationDto dto) {
    // TODO: implement execute
    throw UnimplementedError();
  }

}