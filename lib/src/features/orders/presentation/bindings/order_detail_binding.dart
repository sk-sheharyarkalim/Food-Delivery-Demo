import 'package:get/get.dart';

import 'package:food_delivery/src/features/orders/data/repositories/order_repository_impl.dart';
import 'package:food_delivery/src/features/orders/domain/usecases/get_order_by_id_usecase.dart';
import 'package:food_delivery/src/features/orders/presentation/providers/order_detail_controller.dart';

class OrderDetailBinding implements Bindings {
  @override
  void dependencies() {
    final orderRepository = OrderRepositoryImpl();

    Get.lazyPut<OrderDetailController>(
      () => OrderDetailController(
        getOrderById: GetOrderByIdUseCase(orderRepository),
      ),
    );
  }
}
