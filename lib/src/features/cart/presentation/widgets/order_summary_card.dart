import 'package:food_delivery/src/imports/imports.dart';

/// Order summary card showing subtotal, delivery fee, discount and total.
///
/// Usage:
/// ```dart
/// OrderSummaryCard(
///   subtotal: cart.totalPrice,
///   deliveryFee: CartController.deliveryFee,
///   discount: cart.discount.value,
///   total: cart.total,
/// )
/// ```
class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
  });

  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;

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
        children: [
          _SummaryRow(label: AppStrings.subtotal, value: subtotal),
          SizedBox(height: AppSpacing.sm),
          _SummaryRow(label: AppStrings.deliveryFee, value: deliveryFee),
          SizedBox(height: AppSpacing.sm),
          _SummaryRow(
            label: AppStrings.discount,
            value: -discount,
            valueColor: AppColors.kSuccess,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: const Divider(color: AppColors.kInputBg, height: 1),
          ),
          _SummaryRow(
            label: AppStrings.total,
            value: total,
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isTotal = false,
  });

  final String label;
  final double value;
  final Color? valueColor;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final sign = value < 0 ? '-' : '';
    final amount = '$sign\$${value.abs().toStringAsFixed(2)}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: isTotal ? AppTextStyles.kHeading3 : AppTextStyles.kBody),
        Text(
          amount,
          style: isTotal
              ? AppTextStyles.kPrice.copyWith(fontSize: 17)
              : AppTextStyles.kBody.copyWith(color: valueColor),
        ),
      ],
    );
  }
}
