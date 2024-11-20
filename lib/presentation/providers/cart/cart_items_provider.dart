import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/infraestructure/datasources/cart/cart_item_datasource.dart';
import 'package:go_dely/infraestructure/entities/cart/cart_items.dart';
import 'package:go_dely/infraestructure/repositories/cart/cart_item_repository.dart';

final cartItemsProvider = StateNotifierProvider<CartItemsNotifier, List<CartItem>>(
  (ref) {
    return CartItemsNotifier(repository: CartItemRepository(datasource: CartItemDatasource()));
  },
);


class CartItemsNotifier extends StateNotifier<List<CartItem>>{
  
  final CartItemRepository repository;

  CartItemsNotifier({
    required this.repository ,
  }) : super([]);

  Future<bool> itemExistsInCart(String id) async {
    return repository.itemExistsInCart(id);
  }

  Future<void> addItemToCart(CartItem cartItem) async {
    if(await itemExistsInCart(cartItem.id) == false){
      await repository.addProductToCart(cartItem);
      state = await getAllItemsFromCart();
    }
  }

  Future<void> removeItemFromCart(int id) async {
    await repository.removeProductFromCart(id);
    state = await getAllItemsFromCart();
  }

  Future<List<CartItem>> getAllItemsFromCart() async {
    return repository.getProductsFromCart();
  }

  Future<void> incrementItem(String id) async {
    await repository.incrementProduct(id);
    state = await getAllItemsFromCart();
  }

  Future<void> decrementItem(String id) async {
    await repository.decrementProduct(id);
    state = await getAllItemsFromCart();
  }

  Future<Stream<List<CartItem>>> watchAllItemsFromCart() {
    return repository.watchAllItemsFromCart();
  }

}