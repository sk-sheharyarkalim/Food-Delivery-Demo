import 'package:food_delivery/src/imports/imports.dart';

import 'package:food_delivery/src/features/cart/presentation/providers/cart_controller.dart';
import 'package:food_delivery/src/features/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:food_delivery/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: const [
            MenuScreen(),
            CartScreen(),
            OrdersScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          backgroundColor: context.colors.surface,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: AppStrings.navHome,
            ),
            NavigationDestination(
              icon: _CartIcon(selected: false),
              selectedIcon: _CartIcon(selected: true),
              label: AppStrings.navCart,
            ),
            NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined),
              selectedIcon: Icon(Icons.receipt_long),
              label: AppStrings.navOrders,
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: AppStrings.navProfile,
            ),
          ],
        ),
      ),
    );
  }
}

class _CartIcon extends StatelessWidget {
  const _CartIcon({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Obx(() {
      final itemCount = cartController.totalItems;

      return Badge(
        backgroundColor: AppColors.kPrimary,
        textColor: Colors.white,
        label: Text('$itemCount'),
        isLabelVisible: itemCount > 0,
        child: Icon(selected ? Icons.shopping_cart : Icons.shopping_cart_outlined),
      );
    });
  }
}
