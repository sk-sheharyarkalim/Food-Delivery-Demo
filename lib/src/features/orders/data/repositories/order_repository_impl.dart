import 'package:food_delivery/src/utils/utils.dart';

import 'package:food_delivery/src/features/orders/data/datasources/order_remote_data_source.dart';
import 'package:food_delivery/src/features/orders/data/models/order_model.dart';
import 'package:food_delivery/src/features/orders/domain/entities/order.dart';
import 'package:food_delivery/src/features/orders/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource = OrderRemoteDataSource.instance;

  @override
  FutureEither<String> createOrder(FoodOrder order) {
    return _remoteDataSource.createOrder(OrderModel.fromEntity(order));
  }

  @override
  FutureEither<List<FoodOrder>> getOrders(String userId) async {
    final result = await _remoteDataSource.getOrders(userId);
    return result.map((models) => models.map((model) => model.toEntity()).toList());
  }

  @override
  FutureEither<FoodOrder> getOrderById(String orderId) async {
    final result = await _remoteDataSource.getOrderById(orderId);
    return result.map((model) => model.toEntity());
  }

  @override
  StreamEither<List<FoodOrder>> watchOrders(String userId) {
    return _remoteDataSource.watchOrders(userId).map((either) => either.map((models) => models.map((model) => model.toEntity()).toList()));
  }
}
