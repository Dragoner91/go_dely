import 'package:go_dely/domain/cart/i_cart.dart';

abstract class ICartRepository {
  
  Future<bool> itemExistsInCart(String id);

  Future<void> addItemToCart(ICart cartItem);

  Future<void> removeItemFromCart(int id);
  
  Future<List<ICart>> getItemsFromCart();

  Future<void> incrementItem(String id);

  Future<void> decrementItem(String id);

  Future<Stream<List<ICart>>> watchAllItemsFromCart();

  Future<double> getTotalPrice();

}