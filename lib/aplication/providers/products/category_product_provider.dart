import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/providers/categoria/category_repository_provider.dart';
import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/category/category.dart';
import 'package:go_dely/domain/product/product.dart';
import 'package:go_dely/domain/product/i_product_repository.dart';

final categoriesProductsProvider = StateNotifierProvider<CategoriesProductsNotifier, List<Product>>(
  (ref) {
    final fetchMoreProducts = ref.watch(categoryRepositoryProvider).getProductsFromCategory;
    return CategoriesProductsNotifier(
      fetchMoreProducts: fetchMoreProducts
    );
  },
);

typedef ProductCallback = Future<Result<List<Product>>> Function( GetCategoryByIdDto dto );

class GetCategoriesByIdDto {
}

class CategoriesProductsNotifier extends StateNotifier<List<Product>>{

  int currentPage = 0;
  bool isLoading = false;
  ProductCallback fetchMoreProducts;


  CategoriesProductsNotifier({ required this.fetchMoreProducts}): super([]);

  Future<void> loadNextPage(String categoryId) async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final Result<List<Product>> products = await fetchMoreProducts( GetCategoryByIdDto(id: categoryId, productsDto: GetProductsDto( page: currentPage))  );
    state = [...state, ...products.unwrap()];
    await Future.delayed(const Duration(milliseconds: 500));
    isLoading = false;
  }

  Future<void> refresh(String categoryId) async {
    currentPage = 0;
    state = [];
    await loadNextPage(categoryId);
  }

}