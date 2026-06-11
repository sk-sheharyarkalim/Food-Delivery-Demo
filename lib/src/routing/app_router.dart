import 'package:food_delivery/src/imports/imports.dart';

class AppRouter {
  static List<GetPage<dynamic>> get getPages => [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: AppDurations.pageTransition,
      curve: AppCurves.pageEnter,
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
      transition: Transition.fadeIn,
      transitionDuration: AppDurations.pageTransition,
      curve: AppCurves.pageEnter,
    ),
    GetPage(
      name: AppRoutes.menu,
      page: () => const MenuScreen(),
      binding: MenuBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: AppDurations.pageTransition,
      curve: AppCurves.pageEnter,
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => const ProductDetailScreen(),
      binding: ProductDetailBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: AppDurations.pageTransition,
      curve: AppCurves.pageEnter,
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartScreen(),
      fullscreenDialog: true,
      transition: Transition.downToUp,
      transitionDuration: AppDurations.slow,
      curve: AppCurves.popupOpen,
    ),
    GetPage(
      name: AppRoutes.orders,
      page: () => const OrdersScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: AppDurations.pageTransition,
      curve: AppCurves.pageEnter,
    ),
    GetPage(
      name: AppRoutes.orderDetail,
      page: () => const OrderDetailScreen(),
      binding: OrderDetailBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: AppDurations.pageTransition,
      curve: AppCurves.pageEnter,
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsScreen(),
      binding: NotificationBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: AppDurations.pageTransition,
      curve: AppCurves.pageEnter,
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => const PaymentScreen(),
      binding: PaymentBinding(),
      fullscreenDialog: true,
      transition: Transition.downToUp,
      transitionDuration: AppDurations.slow,
      curve: AppCurves.popupOpen,
    ),
  ];
}
