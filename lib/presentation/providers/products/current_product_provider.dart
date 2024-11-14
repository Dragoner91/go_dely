import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/domain/entities/product/product.dart';

final currentProduct = StateProvider<List<Product>> ((ref) {
  return [];
});