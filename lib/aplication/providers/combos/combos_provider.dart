import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/aplication/providers/combos/combos_repository_provider.dart';
import 'package:go_dely/domain/combo/i_combo_repository.dart';

final combosProvider = StateNotifierProvider<CombosNotifier ,List<Combo>>(
  (ref) {
    final fetchMoreCombos = ref.watch(combosRepositoryProvider).getCombos;
    return CombosNotifier(
      fetchMoreCombos: fetchMoreCombos
    );
  },
);

typedef ComboCallback = Future<Result<List<Combo>>> Function(GetCombosDto dto);

class CombosNotifier extends StateNotifier<List<Combo>>{

  int currentPage = 0;
  bool isLoading = false;
  ComboCallback fetchMoreCombos;


  CombosNotifier({ required this.fetchMoreCombos}): super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final Result<List<Combo>> combos = await fetchMoreCombos( GetCombosDto( page: currentPage ) );
    state = [...state, ...combos.unwrap()];
    await Future.delayed(const Duration(milliseconds: 500));
    isLoading = false;
  }

  Future<void> refresh() async {
    currentPage = 0;
    state = [];
    await loadNextPage();
  }

}