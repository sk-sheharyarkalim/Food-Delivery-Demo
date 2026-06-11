// Flutter SDK
export 'package:flutter/material.dart';
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/foundation.dart';
export 'package:flutter/services.dart';
export 'package:flutter_native_splash/flutter_native_splash.dart';


// Project Core — everything exported through shared.dart (theme, extensions,
// utils, widgets, enums) plus routing and services.
export '../config/app_config.dart';
export '../routing/app_router.dart';
export '../routing/app_routes.dart';
export '../routing/global_navigator.dart';
export '../routing/app_bindings.dart';
export '../services/services.dart';
export '../shared/shared.dart';

export '../features/auth/presentation/screens/login_screen.dart';
export '../features/dashboard/presentation/bindings/dashboard_binding.dart';
export '../features/dashboard/presentation/screens/dashboard_screen.dart';
export '../features/products/presentation/bindings/menu_binding.dart';
export '../features/products/presentation/bindings/product_detail_binding.dart';
export '../features/products/presentation/screens/menu_screen.dart';
export '../features/products/presentation/screens/product_detail_screen.dart';
export '../features/cart/presentation/screens/cart_screen.dart';
export '../features/orders/presentation/bindings/order_detail_binding.dart';
export '../features/orders/presentation/screens/orders_screen.dart';
export '../features/orders/presentation/screens/order_detail_screen.dart';
export '../features/notifications/presentation/bindings/notification_binding.dart';
export '../features/notifications/presentation/screens/notifications_screen.dart';
export '../features/payment/presentation/bindings/payment_binding.dart';
export '../features/payment/presentation/screens/payment_screen.dart';
