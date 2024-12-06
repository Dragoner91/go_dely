import 'package:flutter_riverpod/flutter_riverpod.dart';

final addressSelected = StateProvider<String>(
  (ref) {
    return "";
  },
);