import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/products/domain/entities/product.dart';
import 'package:food_delivery/src/features/products/domain/repositories/product_repository.dart';

/// Returns the list of all products.
class GetProductsUseCase {
  const GetProductsUseCase(this._repository);

  final ProductRepository _repository;

  FutureEither<List<Product>> call() => _repository.getProducts();
}
