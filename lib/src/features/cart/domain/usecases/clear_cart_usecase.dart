import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/cart/domain/repositories/cart_repository.dart';

/// Removes all items from the cart.
class ClearCartUseCase {
  const ClearCartUseCase(this._repository);

  final CartRepository _repository;

  FutureEitherVoid call() => _repository.clearCart();
}
