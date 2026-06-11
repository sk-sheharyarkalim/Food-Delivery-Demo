import 'package:food_delivery/src/utils/utils.dart';

import 'package:food_delivery/src/features/products/data/datasources/product_remote_data_source.dart';
import 'package:food_delivery/src/features/products/domain/entities/category.dart';
import 'package:food_delivery/src/features/products/domain/entities/product.dart';
import 'package:food_delivery/src/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource = ProductRemoteDataSource.instance;

  @override
  FutureEither<List<ProductCategory>> getCategories() async {
    final result = await _remoteDataSource.getCategories();
    return result.map((models) => models.map((model) => model.toEntity()).toList());
  }

  @override
  FutureEither<List<Product>> getProducts() async {
    final result = await _remoteDataSource.getProducts();
    return result.map((models) => models.map((model) => model.toEntity()).toList());
  }

  @override
  FutureEither<List<Product>> getProductsByCategory(String categoryId) async {
    final result = await _remoteDataSource.getProductsByCategory(categoryId);
    return result.map((models) => models.map((model) => model.toEntity()).toList());
  }

  @override
  FutureEither<Product> getProductById(String id) async {
    final result = await _remoteDataSource.getProductById(id);
    return result.map((model) => model.toEntity());
  }
}
