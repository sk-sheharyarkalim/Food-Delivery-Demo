import 'package:get/get.dart';

import 'package:food_delivery/src/features/products/data/repositories/product_repository_impl.dart';
import 'package:food_delivery/src/features/products/domain/usecases/get_categories_usecase.dart';
import 'package:food_delivery/src/features/products/domain/usecases/get_products_by_category_usecase.dart';
import 'package:food_delivery/src/features/products/domain/usecases/get_products_usecase.dart';
import 'package:food_delivery/src/features/products/presentation/providers/menu_controller.dart';

class MenuBinding implements Bindings {
  @override
  void dependencies() {
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
