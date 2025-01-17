import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/providers/order/order_repository_provider.dart';
import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/order/i_order_repository.dart';
import 'package:go_dely/domain/order/order.dart';

final activeOrderProvider = StateNotifierProvider<ActiveOrderNotifier, List<Order>>(
  (ref) {
    final fetchMoreActiveOrders = ref.watch(orderRepositoryProvider).getActiveOrders;
    return ActiveOrderNotifier(
      fetchMoreActiveOrders: fetchMoreActiveOrders
    );
  },
);

typedef OrderCallback = Future<Result<List<Order>>> Function( GetOrdersDto dto );

class ActiveOrderNotifier extends StateNotifier<List<Order>>{

  int currentPage = 0;
  bool isLoading = false;
  OrderCallback fetchMoreActiveOrders;


  ActiveOrderNotifier({ required this.fetchMoreActiveOrders}): super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final Result<List<Order>> orders = await fetchMoreActiveOrders( GetOrdersDto( page: currentPage, perPage: 10 ) );
    state = [...state, ...orders.unwrap()];
    await Future.delayed(const Duration(milliseconds: 500));
    isLoading = false;
  }

  Future<void> refresh() async {
    currentPage = 0;
    state = [];
    await loadNextPage();
  }

}

