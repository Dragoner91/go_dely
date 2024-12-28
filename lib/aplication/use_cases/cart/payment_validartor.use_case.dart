import 'package:go_dely/aplication/dto/payment_validator_dto.dart';
import 'package:go_dely/config/helpers/payment_methods_validators.dart';

class PaymentValidatorUseCase {

  void validatePaymentMethod(PaymentValidatorDto dto) {
    switch (dto.paymentMethod) {
      case 'Credit Card':
      case 'Debit Card':
        validateCardData(dto);
        break;
      case 'Cash':
        validateCashData(dto);
        break;
      case 'Pago Movil':
        validatePagoMovilData(dto);
        break;
      default:
        throw Exception('Payment Method not supported.');
    }
  }

  void validateCardData(PaymentValidatorDto dto) {
    if (!CardValidator.isValidCardNumber(dto.cardNumber!)) {
      throw Exception('Card Number not valid.');
    }
    if (!CardValidator.isValidExpiryDate(dto.cardExpiryDate!)) {
      throw Exception('Expiry Date not valid.');
    }
    if (!CardValidator.isValidCVV(dto.cardCVV!)) {
      throw Exception('CVV not valid.');
    }
  }

  void validateCashData(PaymentValidatorDto dto){
    if(!CashValidator.isValidAmount(dto.cashAmount!)) {
      throw Exception('Cash amount not valid.');
    }
  }

  void validatePagoMovilData(PaymentValidatorDto dto){
    if(!PagoMovilValidator.isValidReferenceNumber(dto.pagoMovilReferenceNumber!)){
      throw Exception('Pago Movil Reference number not valid.');
    }
  }
}