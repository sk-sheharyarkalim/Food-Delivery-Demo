import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

import 'package:food_delivery/src/features/orders/data/models/order_model.dart';

import '../../../../config/app_config.dart';
import '../../../../utils/utils.dart';

class OrderRemoteDataSource {
  OrderRemoteDataSource._();
  static final OrderRemoteDataSource instance = OrderRemoteDataSource._();

  FirebaseFirestore get _firestore => AppConfig.firestore;

  CollectionReference<Map<String, dynamic>> get _ordersRef => _firestore.collection('orders');

  FutureEither<String> createOrder(OrderModel order) async {
    return runTask(() async {
      final docRef = await _ordersRef.add(order.toMap());
      return docRef.id;
    }, requiresNetwork: true);
  }

  FutureEither<List<OrderModel>> getOrders(String userId) async {
    return runTask(() async {
      final snapshot = await _ordersRef.where('userId', isEqualTo: userId).orderBy('createdAt', descending: true).get();
      return snapshot.docs.map((doc) => OrderModel.fromMap(doc.id, doc.data())).toList();
    }, requiresNetwork: true);
  }

  FutureEither<OrderModel> getOrderById(String orderId) async {
    return runTask(() async {
      final doc = await _ordersRef.doc(orderId).get();
      final data = doc.data();
      if (data == null) {
        throw Exception('Order not found');
      }
      return OrderModel.fromMap(doc.id, data);
    }, requiresNetwork: true);
  }

  StreamEither<List<OrderModel>> watchOrders(String userId) {
    return _ordersRef
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      try {
        final orders = snapshot.docs.map((doc) => OrderModel.fromMap(doc.id, doc.data())).toList();
        return right<Failure, List<OrderModel>>(orders);
      } catch (error) {
        return left<Failure, List<OrderModel>>(ServerFailure(AppErrorHandler.format(error), error: error));
      }
    });
  }
}
