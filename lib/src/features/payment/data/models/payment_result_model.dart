import 'package:food_delivery/src/features/payment/domain/entities/payment_result.dart';
import 'package:food_delivery/src/features/payment/domain/entities/payment_status.dart';

class PaymentResultModel extends PaymentResult {
  const PaymentResultModel({
    required super.paymentIntentId,
    required super.status,
    required super.amount,
    required super.currency,
  });

  factory PaymentResultModel.fromMap(Map<String, dynamic> map) => PaymentResultModel(
        paymentIntentId: map['id'] as String? ?? '',
        status: PaymentStatus.fromStripeStatus(map['status'] as String?),
        amount: ((map['amount'] as num?)?.toDouble() ?? 0) / 100,
        currency: map['currency'] as String? ?? 'usd',
      );

  PaymentResult toEntity() => PaymentResult(
        paymentIntentId: paymentIntentId,
        status: status,
        amount: amount,
        currency: currency,
      );
}
