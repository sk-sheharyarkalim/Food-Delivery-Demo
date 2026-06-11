import 'package:food_delivery/src/imports/imports.dart';

/// A promotional banner highlighting a discount/offer.
class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.kPrimary,
        borderRadius: AppBorders.kRadiusCard,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.promoBannerTitle,
                  style: AppTextStyles.kHeading2.copyWith(color: Colors.white),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  AppStrings.promoBannerSubtitle,
                  style: AppTextStyles.kBodySmall.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(width: AppSpacing.sm),
          Container(
            padding: EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.local_offer_outlined, color: Colors.white, size: 32),
          ),
        ],
      ),
    );
  }
}
