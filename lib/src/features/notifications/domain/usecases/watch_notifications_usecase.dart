import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/notifications/domain/entities/app_notification.dart';
import 'package:food_delivery/src/features/notifications/domain/repositories/notification_repository.dart';

/// Streams the notifications belonging to a user, most recent first.
class WatchNotificationsUseCase {
  const WatchNotificationsUseCase(this._repository);

  final NotificationRepository _repository;

  StreamEither<List<AppNotification>> call(String userId) => _repository.watchNotifications(userId);
}
