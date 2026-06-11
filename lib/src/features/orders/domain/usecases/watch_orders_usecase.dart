import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/orders/domain/entities/order.dart';
import 'package:food_delivery/src/features/orders/domain/repositories/order_repository.dart';

/// Streams the orders placed by a user, most recent first.
class WatchOrdersUseCase {
  const WatchOrdersUseCase(this._repository);

  final OrderRepository _repository;

  StreamEither<List<FoodOrder>> call(String userId) => _repository.watchOrders(userId);
}
