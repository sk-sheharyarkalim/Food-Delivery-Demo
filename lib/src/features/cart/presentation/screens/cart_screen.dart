import 'package:food_delivery/src/imports/imports.dart';

import 'package:food_delivery/src/features/cart/presentation/providers/cart_controller.dart';
import 'package:food_delivery/src/features/cart/presentation/widgets/cart_item_tile.dart';
import 'package:food_delivery/src/features/cart/presentation/widgets/order_summary_card.dart';
import 'package:food_delivery/src/features/cart/presentation/widgets/promo_code_tile.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  void _applyPromoCode() {
    showGlobalToast(message: AppStrings.promoCodeComingSoon, status: 'info');
  }

  void _proceedToCheckout() {
    Get.toNamed<void>(AppRoutes.payment);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: AppColors.kBg,
      appBar: AppBar(
        backgroundColor: AppColors.kCard,
        elevation: 0,
        centerTitle: false,
        title: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(AppStrings.cartTitle, style: AppTextStyles.kHeading2),
              Text(
                '${controller.totalItems}${AppStrings.cartItemsCount}',
                style: AppTextStyles.kCaption,
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (controller.items.isEmpty) {
          return const AppEmptyState(
            icon: Icons.shopping_bag_outlined,
            title: AppStrings.emptyCartTitle,
            subtitle: AppStrings.emptyCartSubtitle,
          );
        }

        return ListView(
          padding: EdgeInsets.all(AppSpacing.md),
          children: [
            for (final item in controller.items) ...[
              CartItemTile(
                item: item,
                onIncrement: () => controller.updateProductQuantity(item.productId, item.quantity + 1),
                onDecrement: item.quantity > 1
                    ? () => controller.updateProductQuantity(item.productId, item.quantity - 1)
                    : null,
                onRemove: () => controller.removeProduct(item.productId),
              ),
              SizedBox(height: AppSpacing.md),
            ],
            PromoCodeTile(
              controller: _promoController,
              onApply: _applyPromoCode,
            ),
            SizedBox(height: AppSpacing.md),
            OrderSummaryCard(
              subtotal: controller.totalPrice,
              deliveryFee: CartController.deliveryFee,
              discount: controller.discount.value,
              total: controller.total,
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.items.isEmpty) return const SizedBox.shrink();

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: AppButton(
              label: '${AppStrings.proceedToCheckout}  \$${controller.total.toStringAsFixed(2)}',
              isFullWidth: true,
              height: ButtonSize.medium,
              onPressed: _proceedToCheckout,
            ),
          ),
        );
      }),
    );
  }
}
