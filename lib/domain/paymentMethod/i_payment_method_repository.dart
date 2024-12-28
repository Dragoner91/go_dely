import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/paymentMethod/payment_method.dart';

abstract class IPaymentMethodRepository{

  Future<Result<List<PaymentMethod>>> getPaymentMethods();

}