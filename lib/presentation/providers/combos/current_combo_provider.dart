import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/domain/entities/product/combo.dart';

final currentCombo = StateProvider<List<Combo>> ((ref) {
  return [];
});