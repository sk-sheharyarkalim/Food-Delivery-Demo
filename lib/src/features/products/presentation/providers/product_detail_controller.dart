import 'package:food_delivery/src/imports/core_imports.dart';

import 'package:food_delivery/src/features/products/domain/entities/product.dart';
import 'package:food_delivery/src/features/products/domain/usecases/get_product_by_id_usecase.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  ProductDetailController({
    required GetProductByIdUseCase getProductById,
  }) : _getProductById = getProductById;

  final GetProductByIdUseCase _getProductById;

  final status = AppStatus.initial.obs;
  final product = Rxn<Product>();

  @override
  void onInit() {
    super.onInit();
    final productId = Get.arguments as String?;
    if (productId != null) {
      loadProduct(productId);
    }
  }

  Future<void> loadProduct(String productId) async {
    status.value = AppStatus.loading;

    final result = await _getProductById(productId);
    result.fold(
      (failure) {
        status.value = AppStatus.failure;
        showGlobalToast(message: failure.message, status: 'error');
      },
      (data) {
        product.value = data;
        status.value = AppStatus.success;
      },
    );
  }
}
