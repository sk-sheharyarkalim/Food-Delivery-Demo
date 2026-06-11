import 'package:flutter/material.dart';

import 'package:food_delivery/src/features/notifications/domain/entities/notification_type.dart';
import 'package:food_delivery/src/shared/app_strings.dart';
import 'package:food_delivery/src/theme/app_colors.dart';

({IconData icon, Color bg, Color fg}) notificationIconData(NotificationType type) => switch (type) {
      NotificationType.order => (icon: Icons.shopping_bag, bg: AppColors.kLightOrange, fg: AppColors.kPrimary),
      NotificationType.promo => (icon: Icons.local_offer, bg: AppColors.kLightGreen, fg: AppColors.kSuccess),
      NotificationType.system => (icon: Icons.notifications, bg: AppColors.kInputBg, fg: AppColors.kTextGray),
    };

const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String formatRelativeTime(DateTime time) {
  final diff = DateTime.now().difference(time);

  if (diff.inMinutes < 1) return AppStrings.justNow;
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  if (diff.inDays == 1) return AppStrings.yesterday;
  if (diff.inDays < 7) return '${diff.inDays}d ago';
  return '${_months[time.month - 1]} ${time.day}';
}
