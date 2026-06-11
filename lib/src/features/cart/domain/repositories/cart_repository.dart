import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/cart/domain/entities/cart_item.dart';

abstract class CartRepository {
  /// Returns the items currently in the cart.
  FutureEither<List<CartItem>> getCartItems();

  /// Adds [item] to the cart, merging quantities if the product already exists.
  FutureEitherVoid addToCart(CartItem item);

  /// Removes the item matching [productId] from the cart.
  FutureEitherVoid removeFromCart(String productId);

  /// Updates the quantity of the item matching [productId].
  ///
  /// If [quantity] is 0 or less, the item is removed from the cart.
  FutureEitherVoid updateQuantity(String productId, int quantity);

  /// Removes all items from the cart.
  FutureEitherVoid clearCart();
}
