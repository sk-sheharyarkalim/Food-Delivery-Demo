import 'dart:async';

import 'package:food_delivery/src/imports/core_imports.dart';

import 'package:food_delivery/src/features/auth/presentation/providers/session_controller.dart';
import 'package:food_delivery/src/features/cart/presentation/providers/cart_controller.dart';
import 'package:food_delivery/src/features/notifications/presentation/providers/notification_controller.dart';
import 'package:food_delivery/src/features/orders/domain/entities/order.dart';
import 'package:food_delivery/src/features/orders/domain/entities/order_item.dart';
import 'package:food_delivery/src/features/orders/domain/entities/order_status.dart';
import 'package:food_delivery/src/features/orders/domain/usecases/create_order_usecase.dart';
import 'package:food_delivery/src/features/orders/domain/usecases/watch_orders_usecase.dart';
import 'package:food_delivery/src/features/orders/presentation/utils/order_display_helpers.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  OrderController({
    required CreateOrderUseCase createOrder,
    required WatchOrdersUseCase watchOrders,
  })  : _createOrder = createOrder,
        _watchOrders = watchOrders;

  final CreateOrderUseCase _createOrder;
  final WatchOrdersUseCase _watchOrders;
  StreamSubscription<Either<Failure, List<FoodOrder>>>? _ordersSub;

  final status = AppStatus.initial.obs;
  final orders = <FoodOrder>[].obs;
  final selectedFilter = OrderHistoryFilter.all.obs;

  Map<String, OrderStatus> _lastStatuses = {};
  bool _hasLoadedOnce = false;

  List<FoodOrder> get filteredOrders =>
      orders.where((order) => selectedFilter.value.matches(order.status)).toList();

  @override
  void onInit() {
    super.onInit();
    ever(Get.find<SessionController>().user, (_) => _watchUserOrders());
    _watchUserOrders();
  }

  void _watchUserOrders() {
    unawaited(_ordersSub?.cancel());
    _ordersSub = null;

    final userId = Get.find<SessionController>().user.value?.id;
    if (userId == null) {
      orders.clear();
      _hasLoadedOnce = false;
      _lastStatuses = {};
      return;
    }

    status.value = AppStatus.loading;
    _ordersSub = _watchOrders(userId).listen((result) {
      result.fold(
        (failure) {
          status.value = AppStatus.failure;
          showGlobalToast(message: failure.message, status: 'error');
        },
        (data) {
          _notifyStatusChanges(data);
          orders.assignAll(data);
          status.value = AppStatus.success;
        },
      );
    });
  }

  void _notifyStatusChanges(List<FoodOrder> data) {
    if (_hasLoadedOnce) {
      for (final order in data) {
        final previousStatus = _lastStatuses[order.id];
        if (previousStatus != null && previousStatus != order.status) {
          unawaited(
            Get.find<NotificationController>().createNotification(
              title: AppStrings.orderStatusUpdatedNotificationTitle,
              body: orderStatusUpdateMessage(order),
            ),
          );
        }
      }
    }

    _hasLoadedOnce = true;
    _lastStatuses = {for (final order in data) order.id: order.status};
  }

  Future<String?> placeOrder() async {
    final user = Get.find<SessionController>().user.value;
    if (user == null) return null;

    final cart = Get.find<CartController>();
    if (cart.items.isEmpty) return null;

    status.value = AppStatus.loading;

    final order = FoodOrder(
      id: '',
      userId: user.id,
      items: cart.items
          .map((item) => OrderItem(
                productId: item.productId,
                name: item.name,
                price: item.price,
                quantity: item.quantity,
                imageUrl: item.imageUrl,
              ))
          .toList(),
      totalAmount: cart.totalPrice,
      status: OrderStatus.pending,
      createdAt: DateTime.now(),
    );

    final result = await _createOrder(order);
    return result.fold(
      (failure) async {
        status.value = AppStatus.failure;
        showGlobalToast(message: failure.message, status: 'error');
        return null;
      },
      (orderId) async {
        status.value = AppStatus.success;
        await cart.clearCart();
        return orderId;
      },
    );
  }

  @override
  void onClose() {
    unawaited(_ordersSub?.cancel());
    super.onClose();
  }
}
