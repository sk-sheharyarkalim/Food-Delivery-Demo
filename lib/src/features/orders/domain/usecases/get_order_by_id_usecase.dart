import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/orders/domain/entities/order.dart';
import 'package:food_delivery/src/features/orders/domain/repositories/order_repository.dart';

/// Returns a single order matching the given id.
class GetOrderByIdUseCase {
  const GetOrderByIdUseCase(this._repository);

  final OrderRepository _repository;

  FutureEither<FoodOrder> call(String orderId) => _repository.getOrderById(orderId);
}
