import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/product/product.dart';
import 'package:go_dely/domain/product/i_discount_repository.dart';
import 'package:go_dely/aplication/providers/products/discount_repository_provider.dart';

final discountsProvider = StateNotifierProvider<ProductsNotifier ,List<Product>>(
      (ref) {
    final fetchMoreProducts = ref.watch(discountRepositoryProvider).getDiscounts;
    return ProductsNotifier(
        fetchMoreProducts: fetchMoreProducts
    );
  },
);

typedef ProductCallback = Future<Result<List<Product>>> Function( GetProductsDto dto );

class ProductsNotifier extends StateNotifier<List<Product>>{

  int currentPage = 0;
  bool isLoading = false;
  ProductCallback fetchMoreProducts;


  ProductsNotifier({ required this.fetchMoreProducts}): super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;

    final Result<List<Product>> products = await fetchMoreProducts( GetProductsDto( page: currentPage ) );
    state = [...state, ...products.unwrap()];
    await Future.delayed(const Duration(milliseconds: 500));
    isLoading = false;
  }

}