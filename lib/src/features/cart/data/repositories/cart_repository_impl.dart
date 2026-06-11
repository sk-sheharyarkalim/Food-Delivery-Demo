import 'package:food_delivery/src/utils/utils.dart';

import 'package:food_delivery/src/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:food_delivery/src/features/cart/domain/entities/cart_item.dart';
import 'package:food_delivery/src/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource _localDataSource = CartLocalDataSource.instance;

  @override
  FutureEither<List<CartItem>> getCartItems() async {
    return runTask(() async => _localDataSource.getItems());
  }

  @override
  FutureEitherVoid addToCart(CartItem item) async {
    return runTask(() async => _localDataSource.addItem(item));
  }

  @override
  FutureEitherVoid removeFromCart(String productId) async {
    return runTask(() async => _localDataSource.removeItem(productId));
  }

  @override
  FutureEitherVoid updateQuantity(String productId, int quantity) async {
    return runTask(() async => _localDataSource.updateQuantity(productId, quantity));
  }

  @override
  FutureEitherVoid clearCart() async {
    return runTask(() async => _localDataSource.clear());
  }
}
