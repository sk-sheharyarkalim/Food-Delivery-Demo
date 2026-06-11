import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/orders/domain/entities/order.dart';

abstract class OrderRepository {
  /// Creates [order] and returns the generated order id.
  FutureEither<String> createOrder(FoodOrder order);

  /// Returns all orders placed by [userId], most recent first.
  FutureEither<List<FoodOrder>> getOrders(String userId);

  /// Returns a single order matching [orderId].
  FutureEither<FoodOrder> getOrderById(String orderId);

  /// Streams the orders placed by [userId], most recent first.
  StreamEither<List<FoodOrder>> watchOrders(String userId);
}
