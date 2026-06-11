import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/cart/domain/repositories/cart_repository.dart';

/// Updates the quantity of an item in the cart.
///
/// If [quantity] is 0 or less, the item is removed from the cart.
class UpdateCartQuantityUseCase {
  const UpdateCartQuantityUseCase(this._repository);

  final CartRepository _repository;

  FutureEitherVoid call(String productId, int quantity) => _repository.updateQuantity(productId, quantity);
}
