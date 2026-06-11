import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/notifications/domain/entities/app_notification.dart';
import 'package:food_delivery/src/features/notifications/domain/repositories/notification_repository.dart';

class CreateNotificationUseCase {
  const CreateNotificationUseCase(this._repository);

  final NotificationRepository _repository;

  FutureEitherVoid call(String userId, AppNotification notification) => _repository.createNotification(userId, notification);
}
