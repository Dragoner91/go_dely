import 'package:flutter_riverpod/flutter_riverpod.dart';

final cashAmountProvider = StateProvider<double>(
  (ref) {
    return 0.0;
  },
);