class CardValidator {
  static bool isValidCardNumber(String cardNumber) {
    if (cardNumber.length < 13 || cardNumber.length > 19) {
      return false;
    }
    return _luhnCheck(cardNumber);
  }

  static bool _luhnCheck(String cardNumber) {
    int sum = 0;
    bool alternate = false;
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int n = int.parse(cardNumber[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) {
          n -= 9;
        }
      }
      sum += n;
      alternate = !alternate;
    }
    return (sum % 10 == 0);
  }

  static bool isValidExpiryDate(String expiryDate) {
    final now = DateTime.now();
    final parts = expiryDate.split('/');
    if (parts.length != 2) return false;
    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);
    if (month == null || year == null) return false;
    if (month < 1 || month > 12) return false;
    final expiry = DateTime(2000 + year, month);
    return expiry.isAfter(now);
  }

  static bool isValidCVV(String cvv) {
    return cvv.length == 3 || cvv.length == 4;
  }
}

class CashValidator{
  static bool isValidAmount(double amount) {
    return amount > 0;
  }
}

class PagoMovilValidator {
  static bool isValidReferenceNumber(String referenceNumber) {
    if (referenceNumber.length != 10) {
      return false;
    }
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(referenceNumber);
  }
}