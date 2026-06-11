import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

import 'package:food_delivery/src/features/notifications/data/models/notification_model.dart';

import '../../../../config/app_config.dart';
import '../../../../utils/utils.dart';

class NotificationRemoteDataSource {
  NotificationRemoteDataSource._();
  static final NotificationRemoteDataSource instance = NotificationRemoteDataSource._();

  FirebaseFirestore get _firestore => AppConfig.firestore;

  CollectionReference<Map<String, dynamic>> _notificationsRef(String userId) {
    return _firestore.collection('users').doc(userId).collection('notifications');
  }

  FutureEitherVoid createNotification(String userId, NotificationModel notification) async {
    return runTask(() async {
      await _notificationsRef(userId).add(notification.toMap());
    }, requiresNetwork: true);
  }

  FutureEither<List<NotificationModel>> getNotifications(String userId) async {
    return runTask(() async {
      final snapshot = await _notificationsRef(userId).orderBy('createdAt', descending: true).get();
      return _parseNotifications(snapshot.docs);
    }, requiresNetwork: true);
  }

  StreamEither<List<NotificationModel>> watchNotifications(String userId) {
    return _notificationsRef(userId).orderBy('createdAt', descending: true).snapshots().map((snapshot) {
      try {
        return right<Failure, List<NotificationModel>>(_parseNotifications(snapshot.docs));
      } catch (error) {
        return left<Failure, List<NotificationModel>>(ServerFailure(AppErrorHandler.format(error), error: error));
      }
    });
  }

  /// Parses notification docs, skipping any that don't match the expected
  /// shape instead of failing the whole list.
  List<NotificationModel> _parseNotifications(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    final notifications = <NotificationModel>[];
    for (final doc in docs) {
      try {
        notifications.add(NotificationModel.fromMap(doc.id, doc.data()));
      } catch (error) {
        AppLogger.error('Skipping malformed notification doc ${doc.id}: $error');
      }
    }
    return notifications;
  }

  FutureEitherVoid markAsRead(String userId, String notificationId) async {
    return runTask(() async {
      await _notificationsRef(userId).doc(notificationId).update({'isRead': true});
    }, requiresNetwork: true);
  }

  FutureEitherVoid markAllAsRead(String userId) async {
    return runTask(() async {
      final snapshot = await _notificationsRef(userId).where('isRead', isEqualTo: false).get();
      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.update(doc.reference, {'isRead': true});
      }
      await batch.commit();
    }, requiresNetwork: true);
  }
}
