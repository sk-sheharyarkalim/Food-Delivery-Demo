import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/payment/domain/entities/payment_result.dart';
import 'package:food_delivery/src/features/payment/domain/repositories/payment_repository.dart';

/// Creates and confirms a payment for the given amount and currency.
class ProcessPaymentUseCase {
  const ProcessPaymentUseCase(this._repository);

  final PaymentRepository _repository;

  FutureEither<PaymentResult> call({
    required double amount,
    required String currency,
  }) {
    return _repository.processPayment(amount: amount, currency: currency);
  }
}
