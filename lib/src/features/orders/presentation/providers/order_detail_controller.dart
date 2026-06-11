import 'package:food_delivery/src/imports/core_imports.dart';

import 'package:food_delivery/src/features/orders/domain/entities/order.dart';
import 'package:food_delivery/src/features/orders/domain/usecases/get_order_by_id_usecase.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  OrderDetailController({
    required GetOrderByIdUseCase getOrderById,
  }) : _getOrderById = getOrderById;

  final GetOrderByIdUseCase _getOrderById;

  final status = AppStatus.initial.obs;
  final order = Rxn<FoodOrder>();

  @override
  void onInit() {
    super.onInit();
    final orderId = Get.arguments as String?;
    if (orderId != null) {
      loadOrder(orderId);
    }
  }

  Future<void> loadOrder(String orderId) async {
    status.value = AppStatus.loading;

    final result = await _getOrderById(orderId);
    result.fold(
      (failure) {
        status.value = AppStatus.failure;
        showGlobalToast(message: failure.message, status: 'error');
      },
      (data) {
        order.value = data;
        status.value = AppStatus.success;
      },
    );
  }
}
