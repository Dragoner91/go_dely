class PaymentValidatorDto {
  String? cardNumber;
  String? cardExpiryDate;
  String? cardCVV;
  double? cashAmount;
  String? pagoMovilReferenceNumber;
  String paymentMethod;

  PaymentValidatorDto({
    this.cardNumber,
    this.cardExpiryDate,
    this.cardCVV,
    this.cashAmount,
    this.pagoMovilReferenceNumber,
    required this.paymentMethod
  });
}