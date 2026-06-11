/// Centralized, human-readable copy used across the app's UI.
///
/// Keeping strings here avoids hardcoding text inline in widgets and gives a
/// single place to update copy (or swap in localization later).
abstract final class AppStrings {
  AppStrings._();

  // ── Login screen ─────────────────────────────────────────────────────────
  static const String appName = 'Crave';
  static const String appTagline = 'Your favorite meals, delivered fast';
  static const String continueWithGoogle = 'Continue with Google';
  static const String continueWithEmail = 'Continue with Email';
  static const String orDivider = 'or';
  static const String emailSignInComingSoon = 'Email sign-in is coming soon';
  static const String agreementPrefix = 'By continuing, you agree to our ';
  static const String termsOfService = 'Terms of Service';
  static const String agreementJoiner = ' and ';
  static const String privacyPolicy = 'Privacy Policy';

  // ── Bottom navigation ────────────────────────────────────────────────────
  static const String navHome = 'Home';
  static const String navCart = 'Cart';
  static const String navOrders = 'Orders';
  static const String navProfile = 'Profile';

  // ── Profile screen ───────────────────────────────────────────────────────
  static const String profileTitle = 'Profile';
  static const String guestUser = 'Guest';
  static const String signOut = 'Sign Out';
  static const String signOutConfirmTitle = 'Sign Out';
  static const String signOutConfirmMessage = 'Are you sure you want to sign out?';
  static const String cancel = 'Cancel';

  // ── Cart screen ──────────────────────────────────────────────────────────
  static const String cartTitle = 'My Cart';
  static const String cartItemsCount = ' items';
  static const String emptyCartTitle = 'Your cart is empty';
  static const String emptyCartSubtitle = 'Add items from the menu to get started';
  static const String browseMenu = 'Browse Menu';
  static const String promoCodeHint = 'Promo code';
  static const String applyPromoCode = 'Apply';
  static const String promoCodeComingSoon = 'Promo codes are coming soon';
  static const String subtotal = 'Subtotal';
  static const String deliveryFee = 'Delivery Fee';
  static const String discount = 'Discount';
  static const String total = 'Total';
  static const String proceedToCheckout = 'Proceed to Checkout';

  // ── Home screen ──────────────────────────────────────────────────────────
  static const String deliveringTo = 'Delivering to';
  static const String defaultAddress = '123 Main Street, New York';
  static const String searchHint = 'Search for food...';
  static const String allCategories = 'All';
  static const String popularNearYou = 'Popular near you';
  static const String promoBannerTitle = '50% OFF';
  static const String promoBannerSubtitle = 'On your first order, use code WELCOME50';
  static const String estimatedTimeUnit = 'min';

  // ── Product detail screen ────────────────────────────────────────────────
  static const String sizeRegular = 'Regular';
  static const String sizeLarge = 'Large';
  static const String sizeFamily = 'Family';
  static const String quantityLabel = 'Quantity';
  static const String addToCart = 'Add to Cart';

  // ── Checkout screen ──────────────────────────────────────────────────────
  static const String checkoutTitle = 'Checkout';
  static const String deliveryAddressLabel = 'Home';
  static const String changeLabel = 'Change';
  static const String deliveryInstructionsHint = 'Delivery instructions (optional)';
  static const String cardNumberHint = 'Card number';
  static const String expiryHint = 'MM/YY';
  static const String cvcHint = 'CVC';
  static const String visaEndingIn4242 = 'Visa ending in 4242';
  static const String applePay = 'Apple Pay';
  static const String securedByStripe = 'Secured by Stripe · 256-bit SSL';
  static const String payButtonLabel = 'Pay';
  static const String changeAddressComingSoon = 'Changing the delivery address is coming soon';
  static const String paymentFailedMessage = 'Payment was not completed';
  static const String orderPlacementFailedMessage = 'We could not place your order. Please try again.';
  static const String orderPlacedSuccessMessage = 'Order placed successfully!';

  // ── Order/payment notifications ──────────────────────────────────────────
  static const String paymentSuccessNotificationTitle = 'Payment Successful';
  static const String paymentSuccessNotificationBody = 'Your payment was processed successfully.';
  static const String orderPlacedNotificationTitle = 'Order Placed';
  static const String orderPlacedNotificationBody = 'Your order has been placed and is being prepared.';
  static const String orderStatusUpdatedNotificationTitle = 'Order Status Updated';

  // ── Order tracking screen ────────────────────────────────────────────────
  static const String trackOrderTitle = 'Track Order';
  static const String orderNumberPrefix = 'Order #';
  static const String liveMapPreview = 'Live map preview';
  static const String estimatedArrivalLabel = 'Estimated arrival';
  static const String estimatedArrivalValue = '~10 min';
  static const String driverLabel = 'Driver';
  static const String driverName = 'Marcus D.';
  static const String callDriverComingSoon = 'Calling the driver is coming soon';
  static const String orderStatusTitle = 'Order Status';
  static const String orderItemsTitle = 'Order Items';
  static const String stepOrderPlacedLabel = 'Order Placed';
  static const String stepOrderPlacedSublabel = 'We received your order';
  static const String stepPreparingLabel = 'Preparing';
  static const String stepPreparingSublabel = 'Kitchen is working on it';
  static const String stepOutForDeliveryLabel = 'Out for Delivery';
  static const String stepOutForDeliverySublabel = 'Driver is on the way';
  static const String stepDeliveredLabel = 'Delivered';
  static const String stepDeliveredSublabel = 'Enjoy your meal!';

  // ── Order history screen ─────────────────────────────────────────────────
  static const String myOrdersTitle = 'My Orders';
  static const String filterAll = 'All';
  static const String filterActive = 'Active';
  static const String filterDelivered = 'Delivered';
  static const String filterCancelled = 'Cancelled';
  static const String trackOrderButton = 'Track Order';
  static const String reorderButton = 'Reorder';
  static const String statusOrderPlaced = 'Order Placed';
  static const String statusPreparing = 'Preparing';
  static const String statusOutForDelivery = 'Out for delivery';
  static const String statusDelivered = 'Delivered';
  static const String statusCancelled = 'Cancelled';
  static const String itemsAddedToCart = 'Items added to your cart';
  static const String noOrdersTitle = 'No orders yet';
  static const String noOrdersSubtitle = 'Your past orders will show up here';

  // ── Notifications screen ─────────────────────────────────────────────────
  static const String notificationsTitle = 'Notifications';
  static const String markAllReadLabel = 'Mark all read';
  static const String sectionNew = 'NEW';
  static const String sectionEarlier = 'EARLIER';
  static const String noNotificationsTitle = 'No notifications yet';
  static const String noNotificationsSubtitle = "We'll notify you when something arrives";
  static const String justNow = 'Just now';
  static const String yesterday = 'Yesterday';
}
