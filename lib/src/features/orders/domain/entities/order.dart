import 'package:equatable/equatable.dart';

import 'package:food_delivery/src/features/orders/domain/entities/order_item.dart';
import 'package:food_delivery/src/features/orders/domain/entities/order_status.dart';

class FoodOrder extends Equatable {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double totalAmount;
  final OrderStatus status;
  final DateTime createdAt;

  const FoodOrder({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, userId, items, totalAmount, status, createdAt];
}
