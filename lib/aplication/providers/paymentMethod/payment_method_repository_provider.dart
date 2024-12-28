import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_dely/domain/paymentMethod/i_payment_method_repository.dart';

final paymentMethodRepositoryProvider = Provider((ref) {
    return GetIt.instance.get<IPaymentMethodRepository>();
  },
);