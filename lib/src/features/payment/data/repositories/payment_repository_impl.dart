import 'package:food_delivery/src/utils/utils.dart';

import 'package:food_delivery/src/features/payment/data/datasources/payment_remote_data_source.dart';
import 'package:food_delivery/src/features/payment/domain/entities/payment_result.dart';
import 'package:food_delivery/src/features/payment/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource _remoteDataSource = PaymentRemoteDataSource.instance;

  @override
  FutureEither<PaymentResult> processPayment({
    required double amount,
    required String currency,
  }) async {
    final result = await _remoteDataSource.processPayment(amount: amount, currency: currency);
    return result.map((model) => model.toEntity());
  }
}
