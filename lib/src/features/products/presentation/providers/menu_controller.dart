import 'package:food_delivery/src/imports/core_imports.dart';

import 'package:food_delivery/src/features/products/domain/entities/category.dart';
import 'package:food_delivery/src/features/products/domain/entities/product.dart';
import 'package:food_delivery/src/features/products/domain/usecases/get_categories_usecase.dart';
import 'package:food_delivery/src/features/products/domain/usecases/get_products_by_category_usecase.dart';
import 'package:food_delivery/src/features/products/domain/usecases/get_products_usecase.dart';
import 'package:get/get.dart';

class ProductMenuController extends GetxController {
  ProductMenuController({
    required GetCategoriesUseCase getCategories,
    required GetProductsUseCase getProducts,
    required GetProductsByCategoryUseCase getProductsByCategory,
  })  : _getCategories = getCategories,
        _getProducts = getProducts,
        _getProductsByCategory = getProductsByCategory;

  final GetCategoriesUseCase _getCategories;
  final GetProductsUseCase _getProducts;
  final GetProductsByCategoryUseCase _getProductsByCategory;

  final status = AppStatus.initial.obs;
  final categories = <ProductCategory>[].obs;
  final products = <Product>[].obs;
  final selectedCategoryId = Rxn<String>();
  final searchQuery = ''.obs;

  List<Product> get filteredProducts {
    if (searchQuery.value.isEmpty) return products;
    final query = searchQuery.value.toLowerCase();
    return products.where((product) => product.name.toLowerCase().contains(query)).toList();
  }

  @override
  void onInit() {
    super.onInit();
    loadMenu();
  }

  Future<void> loadMenu() async {
    status.value = AppStatus.loading;

    final categoriesResult = await _getCategories();
    final productsResult = await _getProducts();

    categoriesResult.fold(
      (failure) {
        status.value = AppStatus.failure;
        showGlobalToast(message: failure.message, status: 'error');
      },
      (data) => categories.assignAll(data),
    );

    productsResult.fold(
      (failure) {
        status.value = AppStatus.failure;
        showGlobalToast(message: failure.message, status: 'error');
      },
      (data) {
        products.assignAll(data);
        status.value = AppStatus.success;
      },
    );
  }

  Future<void> selectCategory(String? categoryId) async {
    selectedCategoryId.value = categoryId;
    status.value = AppStatus.loading;

    final result = categoryId == null ? await _getProducts() : await _getProductsByCategory(categoryId);

    result.fold(
      (failure) {
        status.value = AppStatus.failure;
        showGlobalToast(message: failure.message, status: 'error');
      },
      (data) {
        products.assignAll(data);
        status.value = AppStatus.success;
      },
    );
  }
}
