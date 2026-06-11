import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:food_delivery/src/features/orders/data/models/order_item_model.dart';
import 'package:food_delivery/src/features/orders/domain/entities/order.dart';
import 'package:food_delivery/src/features/orders/domain/entities/order_item.dart';
import 'package:food_delivery/src/features/orders/domain/entities/order_status.dart';

class OrderModel extends FoodOrder {
  const OrderModel({
    required super.id,
    required super.userId,
    required super.items,
    required super.totalAmount,
    required super.status,
    required super.createdAt,
  });

  factory OrderModel.fromMap(String id, Map<String, dynamic> map) => OrderModel(
        id: id,
        userId: map['userId'] as String? ?? '',
        items: (map['items'] as List<dynamic>? ?? [])
            .map((item) => OrderItemModel.fromMap(item as Map<String, dynamic>))
            .toList(),
        totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
        status: OrderStatus.fromValue(map['status'] as String?),
        createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      );

  factory OrderModel.fromEntity(FoodOrder order) => OrderModel(
        id: order.id,
        userId: order.userId,
        items: order.items,
        totalAmount: order.totalAmount,
        status: order.status,
        createdAt: order.createdAt,
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'items': items.map((item) => OrderItemModel.fromEntity(item).toMap()).toList(),
        'totalAmount': totalAmount,
        'status': status.value,
        'createdAt': Timestamp.fromDate(createdAt),
      };

  FoodOrder toEntity() => FoodOrder(
        id: id,
        userId: userId,
        items: items.map((item) => OrderItem(
              productId: item.productId,
              name: item.name,
              price: item.price,
              quantity: item.quantity,
              imageUrl: item.imageUrl,
            )).toList(),
        totalAmount: totalAmount,
        status: status,
        createdAt: createdAt,
      );
}
