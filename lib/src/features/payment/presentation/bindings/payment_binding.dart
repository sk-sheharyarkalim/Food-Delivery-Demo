import 'package:get/get.dart';

import 'package:food_delivery/src/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:food_delivery/src/features/payment/domain/usecases/process_payment_usecase.dart';
import 'package:food_delivery/src/features/payment/presentation/providers/payment_controller.dart';

class PaymentBinding implements Bindings {
  @override
  void dependencies() {
    final paymentRepository = PaymentRepositoryImpl();

    Get.lazyPut<PaymentController>(
      () => PaymentController(
        processPayment: ProcessPaymentUseCase(paymentRepository),
      ),
    );
  }
}
