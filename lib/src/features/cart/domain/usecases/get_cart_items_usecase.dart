import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/cart/domain/entities/cart_item.dart';
import 'package:food_delivery/src/features/cart/domain/repositories/cart_repository.dart';

/// Returns the items currently in the cart.
class GetCartItemsUseCase {
  const GetCartItemsUseCase(this._repository);

  final CartRepository _repository;

  FutureEither<List<CartItem>> call() => _repository.getCartItems();
}
