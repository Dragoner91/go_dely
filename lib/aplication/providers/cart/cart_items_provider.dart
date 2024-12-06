import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_dely/domain/cart/i_cart.dart';
import 'package:go_dely/domain/cart/i_cart_repository.dart';

final cartItemsProvider = StateNotifierProvider<CartItemsNotifier, List<ICart>>(
  (ref) {
    return CartItemsNotifier(repository: GetIt.instance.get<ICartRepository>());
  },
);


class CartItemsNotifier extends StateNotifier<List<ICart>>{
  
  final ICartRepository repository;

  CartItemsNotifier({
    required this.repository ,
  }) : super([]);

  Future<bool> itemExistsInCart(String id) async {
    return repository.itemExistsInCart(id);
  }

  Future<void> addItemToCart(ICart cartItem) async {
    if(await itemExistsInCart(cartItem.id) == false){
      await repository.addItemToCart(cartItem);
      state = await getAllItemsFromCart();
    }
  }

  Future<void> removeItemFromCart(int id) async {
    await repository.removeItemFromCart(id);
    state = await getAllItemsFromCart();
  }

  Future<List<ICart>> getAllItemsFromCart() async {
    return repository.getItemsFromCart();
  }

  Future<void> incrementItem(String id) async {
    await repository.incrementItem(id);
    state = await getAllItemsFromCart();
  }

  Future<void> decrementItem(String id) async {
    await repository.decrementItem(id);
    state = await getAllItemsFromCart();
  }

  Future<Stream<List<ICart>>> watchAllItemsFromCart() {
    return repository.watchAllItemsFromCart();
  }

  Future<double> getTotalPrice() async {
    return await repository.getTotalPrice();
  }

}