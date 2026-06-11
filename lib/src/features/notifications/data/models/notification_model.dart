import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:food_delivery/src/features/notifications/domain/entities/app_notification.dart';
import 'package:food_delivery/src/features/notifications/domain/entities/notification_type.dart';

class NotificationModel extends AppNotification {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.createdAt,
    super.isRead,
    super.type,
  });

  factory NotificationModel.fromEntity(AppNotification entity) => NotificationModel(
        id: entity.id,
        title: entity.title,
        body: entity.body,
        isRead: entity.isRead,
        createdAt: entity.createdAt,
        type: entity.type,
      );

  factory NotificationModel.fromMap(String id, Map<String, dynamic> map) => NotificationModel(
        id: id,
        title: map['title'] as String? ?? '',
        body: map['body'] as String? ?? '',
        isRead: map['isRead'] as bool? ?? false,
        createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        type: NotificationType.fromValue(map['type'] as String?),
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'body': body,
        'isRead': isRead,
        'createdAt': Timestamp.fromDate(createdAt),
        'type': type.value,
      };

  AppNotification toEntity() => AppNotification(
        id: id,
        title: title,
        body: body,
        isRead: isRead,
        createdAt: createdAt,
        type: type,
      );
}
