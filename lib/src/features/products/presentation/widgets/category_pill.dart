import 'package:food_delivery/src/imports/imports.dart';

/// A pill-shaped, tappable category filter chip.
///
/// Renders with a [AppColors.kPrimary] background and white text when
/// [isActive] is true, or [AppColors.kInputBg] background and
/// [AppColors.kTextDark] text otherwise.
class CategoryPill extends StatelessWidget {
  const CategoryPill({
    super.key,
    required this.label,
    required this.isActive,
    this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: isActive ? AppColors.kPrimary : AppColors.kInputBg,
          borderRadius: AppBorders.kRadiusPill,
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.kBodySmall.copyWith(
              color: isActive ? Colors.white : AppColors.kTextDark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
