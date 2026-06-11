import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/notifications/domain/entities/app_notification.dart';

abstract class NotificationRepository {
  /// Creates a new notification for [userId].
  FutureEitherVoid createNotification(String userId, AppNotification notification);

  /// Returns the notifications belonging to [userId], most recent first.
  FutureEither<List<AppNotification>> getNotifications(String userId);

  /// Streams the notifications belonging to [userId], most recent first.
  StreamEither<List<AppNotification>> watchNotifications(String userId);

  /// Marks the notification matching [notificationId] as read.
  FutureEitherVoid markAsRead(String userId, String notificationId);

  /// Marks all of [userId]'s notifications as read.
  FutureEitherVoid markAllAsRead(String userId);
}
