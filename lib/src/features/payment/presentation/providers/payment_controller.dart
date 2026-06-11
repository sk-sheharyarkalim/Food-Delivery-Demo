import 'package:food_delivery/src/imports/core_imports.dart';

import 'package:food_delivery/src/features/cart/presentation/providers/cart_controller.dart';
import 'package:food_delivery/src/features/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:food_delivery/src/features/notifications/presentation/providers/notification_controller.dart';
import 'package:food_delivery/src/features/orders/presentation/providers/order_controller.dart';
import 'package:food_delivery/src/features/payment/domain/entities/payment_result.dart';
import 'package:food_delivery/src/features/payment/domain/usecases/process_payment_usecase.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  PaymentController({
    required ProcessPaymentUseCase processPayment,
  }) : _processPayment = processPayment;

  final ProcessPaymentUseCase _processPayment;

  static const String currency = 'usd';

  final status = AppStatus.initial.obs;
  final result = Rxn<PaymentResult>();

  Future<void> pay() async {
    if (status.value == AppStatus.loading) return;

    final cart = Get.find<CartController>();
    if (cart.items.isEmpty) return;

    status.value = AppStatus.loading;

    final paymentResult = await _processPayment(amount: cart.totalPrice, currency: currency);

    await paymentResult.fold(
      (failure) async {
        status.value = AppStatus.failure;
        showGlobalToast(message: failure.message, status: 'error');
      },
      (data) async {
        result.value = data;

        if (!data.isSuccessful) {
          status.value = AppStatus.failure;
          showGlobalToast(message: AppStrings.paymentFailedMessage, status: 'error');
          return;
        }

        await Get.find<NotificationController>().createNotification(
          title: AppStrings.paymentSuccessNotificationTitle,
          body: AppStrings.paymentSuccessNotificationBody,
        );

        final orderId = await Get.find<OrderController>().placeOrder();
        if (orderId == null) {
          status.value = AppStatus.failure;
          showGlobalToast(message: AppStrings.orderPlacementFailedMessage, status: 'error');
          return;
        }

        await Get.find<NotificationController>().createNotification(
          title: AppStrings.orderPlacedNotificationTitle,
          body: AppStrings.orderPlacedNotificationBody,
        );

        status.value = AppStatus.success;
        showGlobalToast(message: AppStrings.orderPlacedSuccessMessage, status: 'success');

        Get.find<DashboardController>().selectedIndex.value = 2;
        Get.until((route) => route.settings.name == AppRoutes.dashboard);
        await Get.toNamed<void>(AppRoutes.orderDetail, arguments: orderId);
      },
    );
  }
}
