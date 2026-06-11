/// Centralized route name constants for named Navigator routes.
///
/// Use these constants with `Navigator.pushNamed(context, AppRoutes.onboarding)`
/// instead of inline strings to prevent typos and ease refactoring.
abstract final class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String menu = '/menu';
  static const String productDetail = '/product-detail';
  static const String cart = '/cart';
  static const String orders = '/orders';
  static const String orderDetail = '/order-detail';
  static const String notifications = '/notifications';
  static const String payment = '/payment';
}
