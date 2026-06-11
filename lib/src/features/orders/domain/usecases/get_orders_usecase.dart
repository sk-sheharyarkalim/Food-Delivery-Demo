import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/orders/domain/entities/order.dart';
import 'package:food_delivery/src/features/orders/domain/repositories/order_repository.dart';

/// Returns all orders placed by a user, most recent first.
class GetOrdersUseCase {
  const GetOrdersUseCase(this._repository);

  final OrderRepository _repository;

  FutureEither<List<FoodOrder>> call(String userId) => _repository.getOrders(userId);
}
