import 'package:food_delivery/src/imports/imports.dart';

import 'package:food_delivery/src/features/cart/domain/entities/cart_item.dart';
import 'package:food_delivery/src/features/cart/presentation/providers/cart_controller.dart';
import 'package:food_delivery/src/features/orders/domain/entities/order.dart';
import 'package:food_delivery/src/features/orders/presentation/providers/order_controller.dart';
import 'package:food_delivery/src/features/orders/presentation/utils/order_display_helpers.dart';
import 'package:food_delivery/src/features/orders/presentation/widgets/order_card.dart';
import 'package:food_delivery/src/features/products/presentation/widgets/category_pill.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  void _onTrackOrder(String orderId) {
    Get.toNamed<void>(AppRoutes.orderDetail, arguments: orderId);
  }

  void _onReorder(FoodOrder order) {
    final cartItems = order.items
        .map((item) => CartItem(
              productId: item.productId,
              name: item.name,
              price: item.price,
              imageUrl: item.imageUrl,
              quantity: item.quantity,
            ))
        .toList();

    Get.find<CartController>().addItems(cartItems);
    showGlobalToast(message: AppStrings.itemsAddedToCart, status: 'success');
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderController>();

    return Scaffold(
      backgroundColor: AppColors.kBg,
      appBar: AppBar(
        backgroundColor: AppColors.kCard,
        elevation: 0,
        title: const Text(AppStrings.myOrdersTitle, style: AppTextStyles.kHeading2),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 44.h,
            child: Obx(() {
              final selectedFilter = controller.selectedFilter.value;

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                itemCount: OrderHistoryFilter.values.length,
                separatorBuilder: (_, __) => SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final filter = OrderHistoryFilter.values[index];
                  return CategoryPill(
                    label: filter.label,
                    isActive: selectedFilter == filter,
                    onTap: () => controller.selectedFilter.value = filter,
                  );
                },
              );
            }),
          ),
          Expanded(
            child: Obx(() {
              if (controller.status.value == AppStatus.loading && controller.orders.isEmpty) {
                return const AppLoading();
              }

              final orders = controller.filteredOrders;
              if (orders.isEmpty) {
                return const AppEmptyState(
                  icon: Icons.receipt_long_outlined,
                  title: AppStrings.noOrdersTitle,
                  subtitle: AppStrings.noOrdersSubtitle,
                );
              }

              return ListView.separated(
                padding: EdgeInsets.all(AppSpacing.md),
                itemCount: orders.length,
                separatorBuilder: (_, __) => SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final isActive = OrderHistoryFilter.active.matches(order.status);

                  return OrderCard(
                    order: order,
                    isActive: isActive,
                    onAction: isActive ? () => _onTrackOrder(order.id) : () => _onReorder(order),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
