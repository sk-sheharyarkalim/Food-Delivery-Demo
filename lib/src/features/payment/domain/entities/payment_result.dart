import 'package:equatable/equatable.dart';

import 'package:food_delivery/src/features/payment/domain/entities/payment_status.dart';

class PaymentResult extends Equatable {
  final String paymentIntentId;
  final PaymentStatus status;
  final double amount;
  final String currency;

  const PaymentResult({
    required this.paymentIntentId,
    required this.status,
    required this.amount,
    required this.currency,
  });

  bool get isSuccessful => status == PaymentStatus.succeeded;

  @override
  List<Object?> get props => [paymentIntentId, status, amount, currency];
}
