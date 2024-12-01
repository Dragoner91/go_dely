import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_dely/domain/product/i_product_repository.dart';

final productRepositoryProvider = Provider((ref) {
    return GetIt.instance.get<IProductRepository>();
  },
);
