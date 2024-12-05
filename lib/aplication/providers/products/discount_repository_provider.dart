import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_dely/domain/product/i_discount_repository.dart';

final discountRepositoryProvider = Provider((ref) {
  return GetIt.instance.get<IDiscountRepository>();
},
);