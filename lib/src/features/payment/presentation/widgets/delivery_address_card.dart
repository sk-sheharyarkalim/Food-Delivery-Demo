import 'package:food_delivery/src/imports/imports.dart';

/// Shows the delivery address with a "Change" action and an optional
/// delivery-instructions field.
class DeliveryAddressCard extends StatelessWidget {
  const DeliveryAddressCard({
    super.key,
    required this.instructionsController,
    this.onChangeAddress,
  });

  final TextEditingController instructionsController;
  final VoidCallback? onChangeAddress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.kCard,
        borderRadius: AppBorders.kRadiusCard,
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppSpacing.sm),
                decoration: const BoxDecoration(
                  color: AppColors.kLightOrange,
                  borderRadius: AppBorders.kRadiusInput,
                ),
                child: const Icon(Icons.location_on, color: AppColors.kPrimary),
              ),
              SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.deliveryAddressLabel,
                      style: AppTextStyles.kBody.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      AppStrings.defaultAddress,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.kCaption,
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: onChangeAddress,
                child: const Text(
                  AppStrings.changeLabel,
                  style: TextStyle(color: AppColors.kPrimary, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: instructionsController,
            hint: AppStrings.deliveryInstructionsHint,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
