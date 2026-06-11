import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/notifications/domain/repositories/notification_repository.dart';

/// Marks all of a user's notifications as read.
class MarkAllAsReadUseCase {
  const MarkAllAsReadUseCase(this._repository);

  final NotificationRepository _repository;

  FutureEitherVoid call(String userId) => _repository.markAllAsRead(userId);
}
