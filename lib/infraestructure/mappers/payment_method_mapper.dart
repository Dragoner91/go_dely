import 'package:go_dely/domain/paymentMethod/payment_method.dart';
import 'package:go_dely/infraestructure/models/payment_method_db.dart';

class PaymentMethodMapper {

  static PaymentMethod paymentMethodToEntity(PaymentMethodDB paymentMethodDB) =>
    PaymentMethod(
      id: paymentMethodDB.id,
      name: paymentMethodDB.name,
    );
}