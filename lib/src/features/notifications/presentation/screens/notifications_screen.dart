import 'package:food_delivery/src/imports/imports.dart';

import 'package:food_delivery/src/features/notifications/presentation/providers/notification_controller.dart';
import 'package:food_delivery/src/features/notifications/presentation/widgets/notification_card.dart';
import 'package:get/get.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();

    return Scaffold(
      backgroundColor: AppColors.kBg,
      appBar: AppBar(
        backgroundColor: AppColors.kCard,
        elevation: 0,
        title: const Text(AppStrings.notificationsTitle, style: AppTextStyles.kHeading2),
        actions: [
          TextButton(
            onPressed: controller.markAllAsRead,
            child: const Text(
              AppStrings.markAllReadLabel,
              style: TextStyle(color: AppColors.kPrimary, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.status.value == AppStatus.loading && controller.notifications.isEmpty) {
          return const AppLoading();
        }

        final unread = controller.notifications.where((notification) => !notification.isRead).toList();
        final read = controller.notifications.where((notification) => notification.isRead).toList();

        if (unread.isEmpty && read.isEmpty) {
          return const AppEmptyState(
            icon: Icons.notifications_none,
            title: AppStrings.noNotificationsTitle,
            subtitle: AppStrings.noNotificationsSubtitle,
          );
        }

        return ListView(
          padding: EdgeInsets.all(AppSpacing.md),
          children: [
            if (unread.isNotEmpty) ...[
              const _SectionLabel(AppStrings.sectionNew),
              SizedBox(height: AppSpacing.sm),
              for (final notification in unread) ...[
                NotificationCard(
                  notification: notification,
                  onTap: () => controller.markAsRead(notification.id),
                ),
                SizedBox(height: AppSpacing.sm),
              ],
              SizedBox(height: AppSpacing.sm),
            ],
            if (read.isNotEmpty) ...[
              const _SectionLabel(AppStrings.sectionEarlier),
              SizedBox(height: AppSpacing.sm),
              for (final notification in read) ...[
                NotificationCard(notification: notification),
                SizedBox(height: AppSpacing.sm),
              ],
            ],
          ],
        );
      }),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.kCaption.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.05),
    );
  }
}
