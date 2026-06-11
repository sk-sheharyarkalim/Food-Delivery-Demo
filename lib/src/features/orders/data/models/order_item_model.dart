import 'package:food_delivery/src/features/orders/domain/entities/order_item.dart';

class OrderItemModel extends OrderItem {
  const OrderItemModel({
    required super.productId,
    required super.name,
    required super.price,
    required super.quantity,
    super.imageUrl,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) => OrderItemModel(
        productId: map['productId'] as String? ?? '',
        name: map['name'] as String? ?? '',
        price: (map['price'] as num?)?.toDouble() ?? 0.0,
        quantity: (map['quantity'] as num?)?.toInt() ?? 0,
        imageUrl: map['imageUrl'] as String?,
      );

  factory OrderItemModel.fromEntity(OrderItem item) => OrderItemModel(
        productId: item.productId,
        name: item.name,
        price: item.price,
        quantity: item.quantity,
        imageUrl: item.imageUrl,
      );

  Map<String, dynamic> toMap() => {
        'productId': productId,
        'name': name,
        'price': price,
        'quantity': quantity,
        'imageUrl': imageUrl,
      };

  OrderItem toEntity() => OrderItem(
        productId: productId,
        name: name,
        price: price,
        quantity: quantity,
        imageUrl: imageUrl,
      );
}
