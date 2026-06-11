import 'package:food_delivery/src/features/orders/domain/entities/order_item.dart';
import 'package:food_delivery/src/imports/imports.dart';

/// A bulleted list of the items included in an order.
class OrderItemsCard extends StatelessWidget {
  const OrderItemsCard({super.key, required this.items});

  final List<OrderItem> items;

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
          const Text(AppStrings.orderItemsTitle, style: AppTextStyles.kHeading3),
          SizedBox(height: AppSpacing.sm),
          for (final item in items)
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.xxs),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: EdgeInsets.only(right: AppSpacing.sm),
                    decoration: const BoxDecoration(color: AppColors.kPrimary, shape: BoxShape.circle),
                  ),
                  Expanded(
                    child: Text('${item.quantity}x ${item.name}', style: AppTextStyles.kBody),
                  ),
                  Text(
                    '\$${item.totalPrice.toStringAsFixed(2)}',
                    style: AppTextStyles.kBody.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
