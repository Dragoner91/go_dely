
import 'package:go_dely/infraestructure/entities/cart/cart_items.dart';
import 'package:go_dely/infraestructure/models/cart_item_local.dart';

class CartItemMapper{

  static CartItem cartItemToEntity(CartLocal cartLocal) => 
    CartItem(
      category: cartLocal.category,
      currency: cartLocal.currency,
      description: cartLocal.description,
      id: cartLocal.id,
      image: cartLocal.image,
      name: cartLocal.name,
      price: cartLocal.price,
      quantity: cartLocal.quantity
    ); 
}