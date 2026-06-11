import 'package:food_delivery/src/imports/imports.dart';

/// A promo code input row with an "Apply" [AppButton].
///
/// Usage:
/// ```dart
/// PromoCodeTile(
///   controller: _promoController,
///   onApply: () => cart.applyPromoCode(_promoController.text),
/// )
/// ```
class PromoCodeTile extends StatelessWidget {
  const PromoCodeTile({
    super.key,
    required this.controller,
    required this.onApply,
  });

  final TextEditingController controller;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.kCard,
        borderRadius: AppBorders.kRadiusCard,
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
              controller: controller,
              hint: AppStrings.promoCodeHint,
              textInputAction: TextInputAction.done,
            ),
          ),
          SizedBox(width: AppSpacing.sm),
          AppButton(
            label: AppStrings.applyPromoCode,
            height: ButtonSize.small,
            width: ButtonSize.small,
            onPressed: onApply,
          ),
        ],
      ),
    );
  }
}
