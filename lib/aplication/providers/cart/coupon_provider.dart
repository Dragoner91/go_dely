import 'package:flutter_riverpod/flutter_riverpod.dart';

final couponProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);