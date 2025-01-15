

import 'package:go_dely/core/result.dart';
import 'package:go_dely/core/use_case.dart';
import 'package:go_dely/domain/discount/discount.dart';
import 'package:go_dely/domain/discount/i_discount_repository.dart';

class GetDiscountByIdUseCase extends IUseCase<GetDiscountByIdDto, Discount> {
  final IDiscountRepository discountRepository;

  GetDiscountByIdUseCase(this.discountRepository);

  @override
  Future<Result<Discount>> execute(GetDiscountByIdDto dto) async {
    return await discountRepository.getDiscountById(dto);
  }

}