import 'package:food_delivery/src/imports/core_imports.dart';

import 'package:food_delivery/src/features/cart/domain/entities/cart_item.dart';
import 'package:food_delivery/src/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:food_delivery/src/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:food_delivery/src/features/cart/domain/usecases/get_cart_items_usecase.dart';
import 'package:food_delivery/src/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:food_delivery/src/features/cart/domain/usecases/update_cart_quantity_usecase.dart';
import 'package:food_delivery/src/features/products/domain/entities/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  CartController({
    required GetCartItemsUseCase getCartItems,
    required AddToCartUseCase addToCart,
    required RemoveFromCartUseCase removeFromCart,
    required UpdateCartQuantityUseCase updateQuantity,
    required ClearCartUseCase clearCart,
  })  : _getCartItems = getCartItems,
        _addToCart = addToCart,
        _removeFromCart = removeFromCart,
        _updateQuantity = updateQuantity,
        _clearCart = clearCart;

  final GetCartItemsUseCase _getCartItems;
  final AddToCartUseCase _addToCart;
  final RemoveFromCartUseCase _removeFromCart;
  final UpdateCartQuantityUseCase _updateQuantity;
  final ClearCartUseCase _clearCart;

  static const double deliveryFee = 2.99;

  final status = AppStatus.initial.obs;
  final items = <CartItem>[].obs;
  final discount = 0.0.obs;

  double get totalPrice => items.fold(0, (sum, item) => sum + item.totalPrice);

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  double get total => totalPrice + deliveryFee - discount.value;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  Future<void> loadCart() async {
    status.value = AppStatus.loading;

    final result = await _getCartItems();
    result.fold(
      (failure) {
        status.value = AppStatus.failure;
        showGlobalToast(message: failure.message, status: 'error');
      },
      (data) {
        items.assignAll(data);
        status.value = AppStatus.success;
      },
    );
  }

  Future<void> addProduct(Product product, {int quantity = 1}) async {
    final result = await _addToCart(
      CartItem(
        productId: product.id,
        name: product.name,
        price: product.price,
        imageUrl: product.imageUrl,
        quantity: quantity,
      ),
    );

    result.fold(
      (failure) => showGlobalToast(message: failure.message, status: 'error'),
      (_) => loadCart(),
    );
  }

  Future<void> addItems(List<CartItem> newItems) async {
    for (final item in newItems) {
      final result = await _addToCart(item);
      result.fold(
        (failure) => showGlobalToast(message: failure.message, status: 'error'),
        (_) {},
      );
    }
    await loadCart();
  }

  Future<void> removeProduct(String productId) async {
    final result = await _removeFromCart(productId);

    result.fold(
      (failure) => showGlobalToast(message: failure.message, status: 'error'),
      (_) => loadCart(),
    );
  }

  Future<void> updateProductQuantity(String productId, int quantity) async {
    final result = await _updateQuantity(productId, quantity);

    result.fold(
      (failure) => showGlobalToast(message: failure.message, status: 'error'),
      (_) => loadCart(),
    );
  }

  Future<void> clearCart() async {
    final result = await _clearCart();

    result.fold(
      (failure) => showGlobalToast(message: failure.message, status: 'error'),
      (_) => loadCart(),
    );
  }
}
