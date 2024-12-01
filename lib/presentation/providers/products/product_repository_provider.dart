import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_dely/infraestructure/repositories/product/product_repository_impl.dart';

final productRepositoryProvider = Provider((ref) {
    return GetIt.instance.get<ProductRepositoryImpl>();
  },
);