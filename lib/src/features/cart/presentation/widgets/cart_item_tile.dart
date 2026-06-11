import 'package:food_delivery/src/imports/imports.dart';

import 'package:food_delivery/src/features/cart/domain/entities/cart_item.dart';
import 'quantity_selector.dart';

/// A single cart item row: image, name/price, remove button and quantity
/// stepper.
///
/// Usage:
/// ```dart
/// CartItemTile(
///   item: item,
///   onIncrement: () => controller.updateProductQuantity(item.productId, item.quantity + 1),
///   onDecrement: () => controller.updateProductQuantity(item.productId, item.quantity - 1),
///   onRemove: () => controller.removeProduct(item.productId),
/// )
/// ```
class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    this.onIncrement,
    this.onDecrement,
    this.onRemove,
  });

  final CartItem item;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onRemove;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: AppBorders.kRadiusInput,
            child: item.imageUrl?.isNotEmpty ?? false
                ? AppCachedImage(
                    imageUrl: item.imageUrl!,
                    width: 64,
                    height: 64,
                  )
                : Container(
                    width: 64.w,
                    height: 64.h,
                    color: AppColors.kInputBg,
                    child: const Icon(Icons.fastfood_outlined, color: AppColors.kTextGray),
                  ),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: AppTextStyles.kHeading3),
                SizedBox(height: AppSpacing.xs),
                Text('\$${item.price.toStringAsFixed(2)}', style: AppTextStyles.kPrice),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: onRemove,
                borderRadius: AppBorders.full,
                child: Container(
                  padding: EdgeInsets.all(AppSpacing.xs),
                  decoration: const BoxDecoration(
                    color: AppColors.kLightOrange,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.delete_outline, size: 18.r, color: AppColors.kPressed),
                ),
              ),
              SizedBox(height: AppSpacing.sm),
              QuantitySelector(
                quantity: item.quantity,
                onIncrement: onIncrement,
                onDecrement: onDecrement,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
