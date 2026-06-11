import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/notifications/domain/repositories/notification_repository.dart';

/// Marks a single notification as read.
class MarkAsReadUseCase {
  const MarkAsReadUseCase(this._repository);

  final NotificationRepository _repository;

  FutureEitherVoid call(String userId, String notificationId) => _repository.markAsRead(userId, notificationId);
}
