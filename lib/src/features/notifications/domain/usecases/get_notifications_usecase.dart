import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/notifications/domain/entities/app_notification.dart';
import 'package:food_delivery/src/features/notifications/domain/repositories/notification_repository.dart';

/// Returns the notifications belonging to a user, most recent first.
class GetNotificationsUseCase {
  const GetNotificationsUseCase(this._repository);

  final NotificationRepository _repository;

  FutureEither<List<AppNotification>> call(String userId) => _repository.getNotifications(userId);
}
