import 'package:food_delivery/src/imports/imports.dart';

/// A row representing a saved payment method, e.g. "Visa ending in 4242".
class SavedMethodTile extends StatelessWidget {
  const SavedMethodTile({
    super.key,
    required this.emoji,
    required this.label,
    this.onTap,
  });

  final String emoji;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.h,
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
        decoration: const BoxDecoration(
          color: AppColors.kInputBg,
          borderRadius: AppBorders.kRadiusInput,
        ),
        child: Row(
          children: [
            Text(emoji, style: AppTextStyles.kBody),
            SizedBox(width: AppSpacing.sm),
            Text(label, style: AppTextStyles.kBodySmall),
            const Spacer(),
            const Icon(Icons.chevron_right, color: AppColors.kTextGray),
          ],
        ),
      ),
    );
  }
}
