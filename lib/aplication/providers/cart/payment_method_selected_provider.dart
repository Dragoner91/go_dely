import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentMethodSelected = StateProvider<String>(
  (ref) {
    return "";
  },
);