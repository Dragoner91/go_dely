
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentOrderId = StateProvider<String> ((ref) {
  return "";
});