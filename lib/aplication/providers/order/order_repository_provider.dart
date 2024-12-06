import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_dely/domain/order/i_order_repository.dart';

final orderRepositoryProvider = Provider((ref) {
    return GetIt.instance.get<IOrderRepository>();
  },
);