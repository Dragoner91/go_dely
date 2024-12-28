import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/paymentMethod/i_payment_method_repository.dart';
import 'package:go_dely/domain/paymentMethod/payment_method.dart';
import 'package:go_dely/infraestructure/datasources/petitions/i_petition.dart';
import 'package:go_dely/infraestructure/mappers/payment_method_mapper.dart';
import 'package:go_dely/infraestructure/models/payment_method_db.dart';

class PaymentMethodRepositoryImpl extends IPaymentMethodRepository{
  final IPetition petition;

  PaymentMethodRepositoryImpl({required this.petition});

  @override
  Future<Result<List<PaymentMethod>>> getPaymentMethods() async {
    final result = await petition.makeRequest(
      urlPath: '/payment-methods',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<PaymentMethod> paymentMethods = [];
        for (var paymentMethod in data) {
          paymentMethods.add(
            PaymentMethodMapper.paymentMethodToEntity(
              PaymentMethodDB.fromJson(paymentMethod)
            )
          );
        }
        return paymentMethods;
      },
    );
    return result;
  }

}