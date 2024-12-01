import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/domain/product/product.dart';

final currentCart = StateProvider<Map<Product, int>>((ref) {
  return <Product, int>{ };
});
