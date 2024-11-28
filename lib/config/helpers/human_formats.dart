import 'package:intl/intl.dart';

class HumanFormarts {
  static String number(double number){
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      locale: 'en',
      symbol: ''
    ).format(number);
    return formattedNumber;
  }

  static String numberCurrency(double number){
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 2,
      locale: 'en',
      symbol: ''
    ).format(number);
    return formattedNumber;
  }

  static String percentage(double number){
    final formattedNumber = NumberFormat.percentPattern().format(number);
    return formattedNumber;
  }

}