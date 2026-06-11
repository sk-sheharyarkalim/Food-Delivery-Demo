import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/payment/domain/entities/payment_result.dart';

abstract class PaymentRepository {
  /// Creates and confirms a payment for [amount] (in major currency units, e.g. dollars)
  /// in the given [currency], returning the resulting [PaymentResult].
  FutureEither<PaymentResult> processPayment({
    required double amount,
    required String currency,
  });
}
