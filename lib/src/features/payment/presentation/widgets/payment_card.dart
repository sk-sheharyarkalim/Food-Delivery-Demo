import 'package:food_delivery/src/imports/imports.dart';

import 'package:food_delivery/src/features/payment/presentation/widgets/saved_method_tile.dart';

/// Card-number/expiry/CVC inputs plus a list of saved payment methods.
class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.cardNumberController,
    required this.expiryController,
    required this.cvcController,
  });

  final TextEditingController cardNumberController;
  final TextEditingController expiryController;
  final TextEditingController cvcController;

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
          AppTextField(
            controller: cardNumberController,
            hint: AppStrings.cardNumberHint,
            keyboardType: TextInputType.number,
            prefixIcon: const Icon(Icons.credit_card),
          ),
          SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: expiryController,
                  hint: AppStrings.expiryHint,
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppTextField(
                  controller: cvcController,
                  hint: AppStrings.cvcHint,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          const SavedMethodTile(emoji: '💳', label: AppStrings.visaEndingIn4242),
          SizedBox(height: AppSpacing.sm),
          const SavedMethodTile(emoji: '🍎', label: AppStrings.applePay),
        ],
      ),
    );
  }
}
