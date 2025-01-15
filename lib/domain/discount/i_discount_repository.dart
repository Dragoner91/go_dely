

import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/discount/discount.dart';

abstract class IDiscountRepository {

  Future<Result<Discount>> getDiscountById(GetDiscountByIdDto dto);
  
}