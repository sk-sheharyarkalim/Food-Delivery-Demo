import 'package:food_delivery/src/features/orders/domain/entities/order.dart';
import 'package:food_delivery/src/features/orders/presentation/utils/order_display_helpers.dart';
import 'package:food_delivery/src/imports/imports.dart';

/// A single order summary card.
///
/// When [isActive] is true the card is highlighted with a primary border and
/// shows a "Track Order" action; otherwise it shows a "Reorder" action.
class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    required this.isActive,
    required this.onAction,
  });

  final FoodOrder order;
  final bool isActive;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final badge = orderStatusBadge(order.status);
    final itemNames = order.items.map((item) => item.name).join(', ');

    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.kCard,
        borderRadius: AppBorders.kRadiusCard,
        border: isActive ? Border.all(color: AppColors.kPrimary, width: 1.5) : null,
        boxShadow: AppShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppStrings.orderNumberPrefix}${formatOrderNumber(order.id)}',
                    style: AppTextStyles.kBody.copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: AppSpacing.xxs),
                  Text(formatOrderDate(order.createdAt), style: AppTextStyles.kCaption),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
                decoration: BoxDecoration(color: badge.bg, borderRadius: AppBorders.kRadiusPill),
                child: Text(
                  badge.label,
                  style: AppTextStyles.kCaption.copyWith(color: badge.fg, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Icon(Icons.inventory_2_outlined, color: AppColors.kTextGray, size: 18),
              SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  itemNames,
                  style: AppTextStyles.kBodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${order.totalAmount.toStringAsFixed(2)}', style: AppTextStyles.kPrice.copyWith(fontSize: 17)),
              AppButton(
                label: isActive ? AppStrings.trackOrderButton : AppStrings.reorderButton,
                onPressed: onAction,
                variant: isActive ? ButtonVariant.primary : ButtonVariant.outline,
                color: isActive ? null : AppColors.kInputBg,
                borderColor: isActive ? null : AppColors.kInputBg,
                textColor: isActive ? null : AppColors.kTextDark,
                height: ButtonSize.small,
                width: ButtonSize.medium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
