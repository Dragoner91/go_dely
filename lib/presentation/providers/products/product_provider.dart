
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/domain/product/product.dart';
import 'package:go_dely/presentation/providers/products/product_repository_provider.dart';

final productsProvider = StateNotifierProvider<ProductsNotifier ,List<Product>>(
  (ref) {
    final fetchMoreProducts = ref.watch(productRepositoryProvider).getProducts;
    return ProductsNotifier(
      fetchMoreProducts: fetchMoreProducts
    );
  },
);

typedef ProductCallback = Future<List<Product>> Function({ int page});

class ProductsNotifier extends StateNotifier<List<Product>>{

  int currentPage = 0;
  bool isLoading = false;
  ProductCallback fetchMoreProducts;


  ProductsNotifier({ required this.fetchMoreProducts}): super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    
    final List<Product> products = await fetchMoreProducts(page: currentPage*5);
    state = [...state, ...products];
    await Future.delayed(const Duration(milliseconds: 500));
    isLoading = false;
  }

}