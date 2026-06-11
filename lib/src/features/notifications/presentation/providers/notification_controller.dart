import 'dart:async';

import 'package:food_delivery/src/imports/core_imports.dart';

import 'package:food_delivery/src/features/auth/presentation/providers/session_controller.dart';
import 'package:food_delivery/src/features/notifications/domain/entities/app_notification.dart';
import 'package:food_delivery/src/features/notifications/domain/entities/notification_type.dart';
import 'package:food_delivery/src/features/notifications/domain/usecases/create_notification_usecase.dart';
import 'package:food_delivery/src/features/notifications/domain/usecases/mark_all_as_read_usecase.dart';
import 'package:food_delivery/src/features/notifications/domain/usecases/mark_as_read_usecase.dart';
import 'package:food_delivery/src/features/notifications/domain/usecases/watch_notifications_usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  NotificationController({
    required WatchNotificationsUseCase watchNotifications,
    required CreateNotificationUseCase createNotification,
    required MarkAsReadUseCase markAsRead,
    required MarkAllAsReadUseCase markAllAsRead,
  })  : _watchNotifications = watchNotifications,
        _createNotification = createNotification,
        _markAsRead = markAsRead,
        _markAllAsRead = markAllAsRead;

  final WatchNotificationsUseCase _watchNotifications;
  final CreateNotificationUseCase _createNotification;
  final MarkAsReadUseCase _markAsRead;
  final MarkAllAsReadUseCase _markAllAsRead;
  StreamSubscription<Either<Failure, List<AppNotification>>>? _notificationsSub;

  final status = AppStatus.initial.obs;
  final notifications = <AppNotification>[].obs;

  int get unreadCount => notifications.where((notification) => !notification.isRead).length;

  @override
  void onInit() {
    super.onInit();
    ever(Get.find<SessionController>().user, (_) => _watchUserNotifications());
    _watchUserNotifications();
  }

  void _watchUserNotifications() {
    unawaited(_notificationsSub?.cancel());
    _notificationsSub = null;

    final userId = Get.find<SessionController>().user.value?.id;
    if (userId == null) {
      notifications.clear();
      return;
    }

    status.value = AppStatus.loading;
    _notificationsSub = _watchNotifications(userId).listen((result) {
      result.fold(
        (failure) {
          status.value = AppStatus.failure;
          showGlobalToast(message: failure.message, status: 'error');
        },
        (data) {
          notifications.assignAll(data);
          status.value = AppStatus.success;
        },
      );
    });
  }

  /// Writes a notification doc for the current user and shows a local
  /// system notification alongside it.
  Future<void> createNotification({
    required String title,
    required String body,
    NotificationType type = NotificationType.order,
  }) async {
    final userId = Get.find<SessionController>().user.value?.id;
    if (userId == null) return;

    final notification = AppNotification(id: '', title: title, body: body, createdAt: DateTime.now(), type: type);

    final result = await _createNotification(userId, notification);
    result.fold(
      (failure) => showGlobalToast(message: failure.message, status: 'error'),
      (_) => null,
    );

    await LocalNotificationService.instance.show(title: title, body: body);
  }

  Future<void> markAsRead(String notificationId) async {
    final userId = Get.find<SessionController>().user.value?.id;
    if (userId == null) return;

    final result = await _markAsRead(userId, notificationId);
    result.fold(
      (failure) => showGlobalToast(message: failure.message, status: 'error'),
      (_) => null,
    );
  }

  Future<void> markAllAsRead() async {
    final userId = Get.find<SessionController>().user.value?.id;
    if (userId == null) return;

    final result = await _markAllAsRead(userId);
    result.fold(
      (failure) => showGlobalToast(message: failure.message, status: 'error'),
      (_) => null,
    );
  }

  @override
  void onClose() {
    unawaited(_notificationsSub?.cancel());
    super.onClose();
  }
}
