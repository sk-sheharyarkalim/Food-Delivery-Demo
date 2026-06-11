import 'package:get/get.dart';

import 'package:food_delivery/src/features/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:food_delivery/src/features/products/presentation/providers/menu_controller.dart';
import 'package:food_delivery/src/features/products/data/repositories/product_repository_impl.dart';
import 'package:food_delivery/src/features/products/domain/usecases/get_categories_usecase.dart';
import 'package:food_delivery/src/features/products/domain/usecases/get_products_by_category_usecase.dart';
import 'package:food_delivery/src/features/products/domain/usecases/get_products_usecase.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());

    final productRepository = ProductRepositoryImpl();

    Get.lazyPut<ProductMenuController>(
      () => ProductMenuController(
        getCategories: GetCategoriesUseCase(productRepository),
        getProducts: GetProductsUseCase(productRepository),
        getProductsByCategory: GetProductsByCategoryUseCase(productRepository),
      ),
    );
  }
}
