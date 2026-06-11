import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/products/domain/entities/product.dart';
import 'package:food_delivery/src/features/products/domain/repositories/product_repository.dart';

/// Returns a single product matching the given id.
class GetProductByIdUseCase {
  const GetProductByIdUseCase(this._repository);

  final ProductRepository _repository;

  FutureEither<Product> call(String id) => _repository.getProductById(id);
}
