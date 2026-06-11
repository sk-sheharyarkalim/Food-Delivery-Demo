import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/cart/domain/repositories/cart_repository.dart';

/// Removes an item from the cart.
class RemoveFromCartUseCase {
  const RemoveFromCartUseCase(this._repository);

  final CartRepository _repository;

  FutureEitherVoid call(String productId) => _repository.removeFromCart(productId);
}
