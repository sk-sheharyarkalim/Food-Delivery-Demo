import 'package:get/get.dart';

import 'package:food_delivery/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:food_delivery/src/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:food_delivery/src/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:food_delivery/src/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:food_delivery/src/features/auth/domain/usecases/watch_auth_state_usecase.dart';
import 'package:food_delivery/src/features/auth/presentation/providers/auth_controller.dart';
import 'package:food_delivery/src/features/auth/presentation/providers/session_controller.dart';
import 'package:food_delivery/src/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:food_delivery/src/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:food_delivery/src/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:food_delivery/src/features/cart/domain/usecases/get_cart_items_usecase.dart';
import 'package:food_delivery/src/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:food_delivery/src/features/cart/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:food_delivery/src/features/cart/presentation/providers/cart_controller.dart';
import 'package:food_delivery/src/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:food_delivery/src/features/notifications/domain/usecases/create_notification_usecase.dart';
import 'package:food_delivery/src/features/notifications/domain/usecases/mark_all_as_read_usecase.dart';
import 'package:food_delivery/src/features/notifications/domain/usecases/mark_as_read_usecase.dart';
import 'package:food_delivery/src/features/notifications/domain/usecases/watch_notifications_usecase.dart';
import 'package:food_delivery/src/features/notifications/presentation/providers/notification_controller.dart';
import 'package:food_delivery/src/features/orders/data/repositories/order_repository_impl.dart';
import 'package:food_delivery/src/features/orders/domain/usecases/create_order_usecase.dart';
import 'package:food_delivery/src/features/orders/domain/usecases/watch_orders_usecase.dart';
import 'package:food_delivery/src/features/orders/presentation/providers/order_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    final authRepository = AuthRepositoryImpl();

    Get.lazyPut<AuthController>(
      () => AuthController(
        signInWithGoogle: SignInWithGoogleUseCase(authRepository),
        signOut: SignOutUseCase(authRepository),
      ),
      fenix: true,
    );

    Get.lazyPut<SessionController>(
      () => SessionController(
        getCurrentUser: GetCurrentUserUseCase(authRepository),
        watchAuthState: WatchAuthStateUseCase(authRepository),
      ),
      fenix: true,
    );

    final cartRepository = CartRepositoryImpl();

    Get.lazyPut<CartController>(
      () => CartController(
        getCartItems: GetCartItemsUseCase(cartRepository),
        addToCart: AddToCartUseCase(cartRepository),
        removeFromCart: RemoveFromCartUseCase(cartRepository),
        updateQuantity: UpdateCartQuantityUseCase(cartRepository),
        clearCart: ClearCartUseCase(cartRepository),
      ),
      fenix: true,
    );

    final orderRepository = OrderRepositoryImpl();

    Get.lazyPut<OrderController>(
      () => OrderController(
        createOrder: CreateOrderUseCase(orderRepository),
        watchOrders: WatchOrdersUseCase(orderRepository),
      ),
      fenix: true,
    );

    final notificationRepository = NotificationRepositoryImpl();

    Get.lazyPut<NotificationController>(
      () => NotificationController(
        watchNotifications: WatchNotificationsUseCase(notificationRepository),
        createNotification: CreateNotificationUseCase(notificationRepository),
        markAsRead: MarkAsReadUseCase(notificationRepository),
        markAllAsRead: MarkAllAsReadUseCase(notificationRepository),
      ),
      fenix: true,
    );
  }
}
