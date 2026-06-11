import 'package:food_delivery/src/imports/imports.dart';

import 'package:food_delivery/src/features/auth/presentation/providers/auth_controller.dart';
import 'package:food_delivery/src/features/auth/presentation/providers/session_controller.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _confirmSignOut(BuildContext context, AuthController controller) async {
    final confirmed = await showAppDialog<bool>(
      child: AlertDialog(
        title: const Text(AppStrings.signOutConfirmTitle),
        content: const Text(AppStrings.signOutConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text(AppStrings.signOut),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      await controller.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = Get.find<SessionController>();
    final auth = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppStrings.profileTitle, style: context.typography.headlineLarge,),
      ),
      body: Obx(() {
        final user = session.user.value;
        final hasPhoto = user?.photoUrl != null && user!.photoUrl!.isNotEmpty;
        final displayName = (user?.name?.isNotEmpty ?? false) ? user!.name! : AppStrings.guestUser;

        return Padding(
          padding: EdgeInsets.all(AppSpacing.pagePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundColor: context.colors.primaryContainer,
                backgroundImage: hasPhoto ? NetworkImage(user.photoUrl!) : null,
                child: hasPhoto
                    ? null
                    : Icon(
                        Icons.person,
                        size: 40.r,
                        color: context.colors.onPrimaryContainer,
                      ),
              ).center,
              SizedBox(height: AppSpacing.md),
              Text(
                displayName,
                style: context.typography.titleLarge,
                textAlign: TextAlign.center,
              ),
              if (user?.email.isNotEmpty ?? false) ...[
                SizedBox(height: AppSpacing.xs),
                Text(
                  user!.email,
                  style: context.typography.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
              ],
              SizedBox(height: AppSpacing.xl),
              Obx(
                () => AppButton(
                  label: AppStrings.signOut,
                  variant: ButtonVariant.danger,
                  isFullWidth: true,
                  isLoading: auth.status.value == AppStatus.loading,
                  onPressed: () => _confirmSignOut(context, auth),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
