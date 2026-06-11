import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:food_delivery/src/features/payment/data/models/payment_result_model.dart';

import '../../../../utils/utils.dart';

/// Creates and confirms Stripe PaymentIntents directly against the Stripe API
/// using the test-mode secret key. Confirms with Stripe's predefined test
/// card payment method (`pm_card_visa`) since no card-entry UI is built yet.
class PaymentRemoteDataSource {
  PaymentRemoteDataSource._();
  static final PaymentRemoteDataSource instance = PaymentRemoteDataSource._();

  static const String _baseUrl = 'https://api.stripe.com/v1';
  static const String _testPaymentMethod = 'pm_card_visa';

  Dio get _dio => Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          headers: {
            'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

  FutureEither<PaymentResultModel> processPayment({
    required double amount,
    required String currency,
  }) async {
    return runTask(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        '/payment_intents',
        data: {
          'amount': (amount * 100).round().toString(),
          'currency': currency,
          'payment_method': _testPaymentMethod,
          'confirm': 'true',
          'automatic_payment_methods[enabled]': 'true',
          'automatic_payment_methods[allow_redirects]': 'never',
        },
      );

      return PaymentResultModel.fromMap(response.data ?? {});
    }, requiresNetwork: true);
  }
}
