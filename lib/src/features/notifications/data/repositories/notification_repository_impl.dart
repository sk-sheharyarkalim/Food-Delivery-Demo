import 'package:food_delivery/src/utils/utils.dart';

import 'package:food_delivery/src/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:food_delivery/src/features/notifications/data/models/notification_model.dart';
import 'package:food_delivery/src/features/notifications/domain/entities/app_notification.dart';
import 'package:food_delivery/src/features/notifications/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource = NotificationRemoteDataSource.instance;

  @override
  FutureEitherVoid createNotification(String userId, AppNotification notification) {
    return _remoteDataSource.createNotification(userId, NotificationModel.fromEntity(notification));
  }

  @override
  FutureEither<List<AppNotification>> getNotifications(String userId) async {
    final result = await _remoteDataSource.getNotifications(userId);
    return result.map((models) => models.map((model) => model.toEntity()).toList());
  }

  @override
  StreamEither<List<AppNotification>> watchNotifications(String userId) {
    return _remoteDataSource
        .watchNotifications(userId)
        .map((either) => either.map((models) => models.map((model) => model.toEntity()).toList()));
  }

  @override
  FutureEitherVoid markAsRead(String userId, String notificationId) {
    return _remoteDataSource.markAsRead(userId, notificationId);
  }

  @override
  FutureEitherVoid markAllAsRead(String userId) {
    return _remoteDataSource.markAllAsRead(userId);
  }
}
