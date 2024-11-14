
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/domain/entities/product/combo.dart';
import 'package:go_dely/presentation/providers/combos/combos_repository_provider.dart';

final combosProvider = StateNotifierProvider<CombosNotifier ,List<Combo>>(
  (ref) {
    final fetchMoreCombos = ref.watch(combosRepositoryProvider).getCombos;
    return CombosNotifier(
      fetchMoreCombos: fetchMoreCombos
    );
  },
);

typedef ComboCallback = Future<List<Combo>> Function({ int page});

class CombosNotifier extends StateNotifier<List<Combo>>{

  int currentPage = 0;
  bool isLoading = false;
  ComboCallback fetchMoreCombos;


  CombosNotifier({ required this.fetchMoreCombos}): super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    
    final List<Combo> combos = await fetchMoreCombos(page: currentPage);
    state = [...state, ...combos];
    await Future.delayed(const Duration(milliseconds: 500));
    isLoading = false;
  }

}