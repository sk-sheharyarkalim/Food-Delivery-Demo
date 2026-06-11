import 'package:flutter/material.dart';

import 'package:food_delivery/src/features/orders/domain/entities/order.dart';
import 'package:food_delivery/src/features/orders/domain/entities/order_status.dart';
import 'package:food_delivery/src/shared/app_strings.dart';
import 'package:food_delivery/src/theme/app_colors.dart';

int trackingStepIndex(OrderStatus status) => switch (status) {
      OrderStatus.pending => 0,
      OrderStatus.preparing => 1,
      OrderStatus.onTheWay => 2,
      OrderStatus.delivered => 3,
      OrderStatus.cancelled => 0,
    };

String formatOrderNumber(String id) {
  final code = id.length >= 4 ? id.substring(id.length - 4) : id;
  return code.toUpperCase();
}

String formatOrderTime(DateTime time) {
  final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = time.hour >= 12 ? 'PM' : 'AM';
  return '$hour:$minute $period';
}

const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String formatOrderDate(DateTime date) => '${_months[date.month - 1]} ${date.day}, ${date.year}';

({String label, Color bg, Color fg}) orderStatusBadge(OrderStatus status) => switch (status) {
      OrderStatus.pending => (label: AppStrings.statusOrderPlaced, bg: AppColors.kLightOrange, fg: AppColors.kPrimary),
      OrderStatus.preparing => (label: AppStrings.statusPreparing, bg: AppColors.kLightOrange, fg: AppColors.kPrimary),
      OrderStatus.onTheWay => (label: AppStrings.statusOutForDelivery, bg: AppColors.kLightOrange, fg: AppColors.kPrimary),
      OrderStatus.delivered => (label: AppStrings.statusDelivered, bg: AppColors.kLightGreen, fg: AppColors.kSuccess),
      OrderStatus.cancelled => (label: AppStrings.statusCancelled, bg: AppColors.kInputBg, fg: AppColors.kTextGray),
    };

String orderStatusUpdateMessage(FoodOrder order) =>
    'Order #${formatOrderNumber(order.id)} is now ${orderStatusBadge(order.status).label}';

/// Filters available on the order history screen.
enum OrderHistoryFilter {
  all,
  active,
  delivered,
  cancelled;

  String get label => switch (this) {
        OrderHistoryFilter.all => AppStrings.filterAll,
        OrderHistoryFilter.active => AppStrings.filterActive,
        OrderHistoryFilter.delivered => AppStrings.filterDelivered,
        OrderHistoryFilter.cancelled => AppStrings.filterCancelled,
      };

  bool matches(OrderStatus status) => switch (this) {
        OrderHistoryFilter.all => true,
        OrderHistoryFilter.active => status != OrderStatus.delivered && status != OrderStatus.cancelled,
        OrderHistoryFilter.delivered => status == OrderStatus.delivered,
        OrderHistoryFilter.cancelled => status == OrderStatus.cancelled,
      };
}
