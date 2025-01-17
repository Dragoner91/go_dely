import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/providers/order/order_repository_provider.dart';
import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/order/i_order_repository.dart';
import 'package:go_dely/domain/order/order.dart';

final pastOrderProvider = StateNotifierProvider<PastOrderNotifier, List<Order>>(
  (ref) {
    final fetchMorePastOrders = ref.watch(orderRepositoryProvider).getPastOrders;
    return PastOrderNotifier(
      fetchMorePastOrders: fetchMorePastOrders
    );
  },
);

typedef OrderCallback = Future<Result<List<Order>>> Function( GetOrdersDto dto );

class PastOrderNotifier extends StateNotifier<List<Order>>{

  int currentPage = 0;
  bool isLoading = false;
  OrderCallback fetchMorePastOrders;


  PastOrderNotifier({ required this.fetchMorePastOrders}): super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final Result<List<Order>> orders = await fetchMorePastOrders( GetOrdersDto( page: currentPage, perPage: 10 ) );
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

