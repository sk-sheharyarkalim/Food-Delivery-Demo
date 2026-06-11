import 'package:food_delivery/src/features/cart/domain/entities/cart_item.dart';

/// In-memory storage for the shopping cart, kept for the lifetime of the app session.
class CartLocalDataSource {
  CartLocalDataSource._();
  static final CartLocalDataSource instance = CartLocalDataSource._();

  final List<CartItem> _items = [];

  List<CartItem> getItems() => List.unmodifiable(_items);

  void addItem(CartItem item) {
    final index = _items.indexWhere((existing) => existing.productId == item.productId);

    if (index == -1) {
      _items.add(item);
    } else {
      _items[index] = _items[index].copyWith(quantity: _items[index].quantity + item.quantity);
    }
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.productId == productId);
  }

  void updateQuantity(String productId, int quantity) {
    final index = _items.indexWhere((item) => item.productId == productId);
    if (index == -1) return;

    if (quantity <= 0) {
      _items.removeAt(index);
    } else {
      _items[index] = _items[index].copyWith(quantity: quantity);
    }
  }

  void clear() {
    _items.clear();
  }
}
