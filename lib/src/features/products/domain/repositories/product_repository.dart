import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/products/domain/entities/category.dart';
import 'package:food_delivery/src/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  /// Returns the list of available product categories.
  FutureEither<List<ProductCategory>> getCategories();

  /// Returns the list of all products.
  FutureEither<List<Product>> getProducts();

  /// Returns the list of products belonging to [categoryId].
  FutureEither<List<Product>> getProductsByCategory(String categoryId);

  /// Returns a single product matching [id].
  FutureEither<Product> getProductById(String id);
}
