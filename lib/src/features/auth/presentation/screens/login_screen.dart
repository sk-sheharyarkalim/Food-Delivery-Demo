import 'package:food_delivery/src/imports/imports.dart';

import 'package:food_delivery/src/features/auth/presentation/providers/auth_controller.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80.r,
                  height: 80.r,
                  decoration: BoxDecoration(
                    color: AppColors.kPrimary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.delivery_dining,
                    size: 40.r,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                Text(
                  AppStrings.appName,
                  style: AppTextStyles.kHeading1.copyWith(fontSize: 28.sp),
                ),
                SizedBox(height: AppSpacing.xs),
                const Text(
                  AppStrings.appTagline,
                  style: AppTextStyles.kCaption,
                ),
                SizedBox(height: AppSpacing.xxl),
                Obx(
                  () => AppButton(
                    label: AppStrings.continueWithGoogle,
                    variant: ButtonVariant.outline,
                    color: AppColors.kCard,
                    textColor: AppColors.kTextDark,
                    borderColor: const Color(0x1F000000),
                    isFullWidth: true,
                    height: ButtonSize.medium,
                    isLoading: controller.status.value == AppStatus.loading,
                    prefixIcon: SvgPicture.asset(
                      AppAssets.googleIcon,
                      width: 20.r,
                      height: 20.r,
                    ),
                    onPressed: controller.signInWithGoogle,
                  ),
                ),
                SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.kInputBg)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                      child: const Text(AppStrings.orDivider, style: AppTextStyles.kCaption),
                    ),
                    const Expanded(child: Divider(color: AppColors.kInputBg)),
                  ],
                ),
                SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: AppStrings.continueWithEmail,
                  isFullWidth: true,
                  height: ButtonSize.medium,
                  onPressed: () => showGlobalToast(
                    message: AppStrings.emailSignInComingSoon,
                    status: 'info',
                  ),
                ),
                SizedBox(height: AppSpacing.xl),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: AppTextStyles.kCaption,
                    children: [
                      TextSpan(text: AppStrings.agreementPrefix),
                      TextSpan(
                        text: AppStrings.termsOfService,
                        style: TextStyle(color: AppColors.kPrimary),
                      ),
                      TextSpan(text: AppStrings.agreementJoiner),
                      TextSpan(
                        text: AppStrings.privacyPolicy,
                        style: TextStyle(color: AppColors.kPrimary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
