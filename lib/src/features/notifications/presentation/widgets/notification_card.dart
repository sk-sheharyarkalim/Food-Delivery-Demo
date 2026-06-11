import 'package:food_delivery/src/features/notifications/domain/entities/app_notification.dart';
import 'package:food_delivery/src/features/notifications/presentation/utils/notification_display_helpers.dart';
import 'package:food_delivery/src/imports/imports.dart';

/// A single notification row, color-coded by [AppNotification.type].
///
/// Read notifications are rendered at reduced opacity; unread notifications
/// show a primary-colored dot in the top-right corner.
class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification, this.onTap});

  final AppNotification notification;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final iconData = notificationIconData(notification.type);

    return Opacity(
      opacity: notification.isRead ? 0.75 : 1,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: const BoxDecoration(
                color: AppColors.kCard,
                borderRadius: AppBorders.kRadiusCard,
                boxShadow: AppShadows.card,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(color: iconData.bg, borderRadius: AppBorders.kRadiusInput),
                    child: Icon(iconData.icon, color: iconData.fg, size: 20),
                  ),
                  SizedBox(width: AppSpacing.ms),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notification.title,
                                style: AppTextStyles.kBody.copyWith(
                                  fontWeight: notification.isRead ? FontWeight.w400 : FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: AppSpacing.sm),
                            Text(formatRelativeTime(notification.createdAt), style: AppTextStyles.kCaption),
                          ],
                        ),
                        SizedBox(height: AppSpacing.xxs),
                        Text(
                          notification.body,
                          style: AppTextStyles.kBodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (!notification.isRead)
              Positioned(
                top: AppSpacing.sm,
                right: AppSpacing.sm,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: AppColors.kPrimary, shape: BoxShape.circle),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
