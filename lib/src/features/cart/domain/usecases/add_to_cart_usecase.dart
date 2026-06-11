import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/cart/domain/entities/cart_item.dart';
import 'package:food_delivery/src/features/cart/domain/repositories/cart_repository.dart';

/// Adds an item to the cart, merging quantities if the product already exists.
class AddToCartUseCase {
  const AddToCartUseCase(this._repository);

  final CartRepository _repository;

  FutureEitherVoid call(CartItem item) => _repository.addToCart(item);
}
