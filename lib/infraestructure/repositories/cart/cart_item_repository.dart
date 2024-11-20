import 'package:go_dely/infraestructure/datasources/cart/cart_item_datasource.dart';
import 'package:go_dely/infraestructure/entities/cart/cart_items.dart';

class CartItemRepository {

  final CartItemDatasource datasource;

  CartItemRepository({required this.datasource});


  Future<void> addProductToCart(CartItem cartItem) async {
    return datasource.addItemToCart(cartItem);
  }

  Future<void> removeProductFromCart(int id) async {
    return datasource.removeItemFromCart(id);
  }

  Future<List<CartItem>> getProductsFromCart() async {
    return datasource.getProductsFromCart();
  }

  Future<void> incrementProduct(String id) async {
    return datasource.incrementItem(id);
  }
  
  Future<void> decrementProduct(String id) async {
    return datasource.decrementItem(id);
  }

  Future<Stream<List<CartItem>>> watchAllItemsFromCart() {
    return datasource.watchAllItemsFromCart();
  }
}