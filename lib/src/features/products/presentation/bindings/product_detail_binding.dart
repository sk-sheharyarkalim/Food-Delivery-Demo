import 'package:get/get.dart';

import 'package:food_delivery/src/features/products/data/repositories/product_repository_impl.dart';
import 'package:food_delivery/src/features/products/domain/usecases/get_product_by_id_usecase.dart';
import 'package:food_delivery/src/features/products/presentation/providers/product_detail_controller.dart';

class ProductDetailBinding implements Bindings {
  @override
  void dependencies() {
    final productRepository = ProductRepositoryImpl();

    Get.lazyPut<ProductDetailController>(
      () => ProductDetailController(
        getProductById: GetProductByIdUseCase(productRepository),
      ),
    );
  }
}
