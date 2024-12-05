import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderSelectedProvider = StateProvider<String> ((ref) {
  return 'Active';
});