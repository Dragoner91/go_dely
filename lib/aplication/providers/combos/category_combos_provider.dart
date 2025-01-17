import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/providers/categoria/category_repository_provider.dart';
import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/category/category.dart';
import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/domain/combo/i_combo_repository.dart';

final categoriesCombosProvider = StateNotifierProvider<CategoryCombosNotifier ,List<Combo>>(
  (ref) {
    final fetchMoreCombos = ref.watch(categoryRepositoryProvider).getCombosFromCategory;
    return CategoryCombosNotifier(
      fetchMoreCombos: fetchMoreCombos
    );
  },
);

typedef ComboCallback = Future<Result<List<Combo>>> Function( GetCategoryByIdDto dto);

class CategoryCombosNotifier extends StateNotifier<List<Combo>>{

  int currentPage = 0;
  bool isLoading = false;
  ComboCallback fetchMoreCombos;


  CategoryCombosNotifier({ required this.fetchMoreCombos}): super([]);

  Future<void> loadNextPage(String categoryId) async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final Result<List<Combo>> combos = await fetchMoreCombos( GetCategoryByIdDto(id: categoryId, combosDto: GetCombosDto(page: currentPage)) );
    state = [...state, ...combos.unwrap()];
    await Future.delayed(const Duration(milliseconds: 500));
    isLoading = false;
  }

  Future<void> refresh(String categoryId) async {
    currentPage = 0;
    state = [];
    await loadNextPage(categoryId);
  }

}