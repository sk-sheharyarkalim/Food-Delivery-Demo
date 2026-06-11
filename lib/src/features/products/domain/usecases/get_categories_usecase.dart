import 'package:food_delivery/src/utils/utils.dart';
import 'package:food_delivery/src/features/products/domain/entities/category.dart';
import 'package:food_delivery/src/features/products/domain/repositories/product_repository.dart';

/// Returns the list of available product categories.
class GetCategoriesUseCase {
  const GetCategoriesUseCase(this._repository);

  final ProductRepository _repository;

  FutureEither<List<ProductCategory>> call() => _repository.getCategories();
}
