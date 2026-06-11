import 'package:food_delivery/src/imports/imports.dart';

/// A small "- qty +" stepper used on cart item tiles.
///
/// Usage:
/// ```dart
/// QuantitySelector(
///   quantity: item.quantity,
///   onIncrement: () => controller.updateProductQuantity(id, qty + 1),
///   onDecrement: () => controller.updateProductQuantity(id, qty - 1),
/// )
/// ```
class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.quantity,
    this.onIncrement,
    this.onDecrement,
  });

  final int quantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _QuantityButton(
          icon: Icons.remove,
          color: AppColors.kTextGray,
          onTap: onDecrement,
        ),
        SizedBox(width: AppSpacing.sm),
        Text(
          '$quantity',
          style: AppTextStyles.kBody.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(width: AppSpacing.sm),
        _QuantityButton(
          icon: Icons.add,
          color: AppColors.kPrimary,
          onTap: onIncrement,
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    required this.color,
    this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppBorders.full,
      child: Container(
        width: 28.r,
        height: 28.r,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16.r, color: color),
      ),
    );
  }
}
