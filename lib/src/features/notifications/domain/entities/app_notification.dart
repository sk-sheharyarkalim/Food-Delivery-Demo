import 'package:equatable/equatable.dart';

import 'package:food_delivery/src/features/notifications/domain/entities/notification_type.dart';

class AppNotification extends Equatable {
  final String id;
  final String title;
  final String body;
  final bool isRead;
  final DateTime createdAt;
  final NotificationType type;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    this.isRead = false,
    this.type = NotificationType.system,
  });

  @override
  List<Object?> get props => [id, title, body, isRead, createdAt, type];
}
