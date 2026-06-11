import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import 'permission_service.dart';

/// Shows system-level local notifications for in-app events (order status
/// changes, payment results) while the app process is alive.
class LocalNotificationService {
  LocalNotificationService._();
  static final LocalNotificationService instance = LocalNotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _androidDetails = AndroidNotificationDetails(
    'order_updates',
    'Order Updates',
    channelDescription: 'Payment confirmations and order status updates',
    importance: Importance.high,
    priority: Priority.high,
  );

  static const NotificationDetails _details = NotificationDetails(
    android: _androidDetails,
    iOS: DarwinNotificationDetails(),
  );

  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _plugin.initialize(settings);
    await PermissionService.instance.request(Permission.notification);
  }

  Future<void> show({required String title, required String body}) {
    final id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    return _plugin.show(id, title, body, _details);
  }
}
