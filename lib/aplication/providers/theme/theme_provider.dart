import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentThemeIsDark = StateProvider<bool> ((ref) {
  return false;
});