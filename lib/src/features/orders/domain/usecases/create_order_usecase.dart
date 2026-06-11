import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/orders/domain/entities/order.dart';
import 'package:food_delivery/src/features/orders/domain/repositories/order_repository.dart';

/// Creates a new order and returns the generated order id.
class CreateOrderUseCase {
  const CreateOrderUseCase(this._repository);

  final OrderRepository _repository;

  FutureEither<String> call(FoodOrder order) => _repository.createOrder(order);
}
