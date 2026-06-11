/// Outcome states of a payment attempt.
enum PaymentStatus {
  succeeded,
  requiresAction,
  canceled,
  failed;

  static PaymentStatus fromStripeStatus(String? status) {
    switch (status) {
      case 'succeeded':
        return PaymentStatus.succeeded;
      case 'canceled':
        return PaymentStatus.canceled;
      case 'requires_action':
      case 'requires_confirmation':
      case 'requires_capture':
      case 'processing':
        return PaymentStatus.requiresAction;
      default:
        return PaymentStatus.failed;
    }
  }
}
