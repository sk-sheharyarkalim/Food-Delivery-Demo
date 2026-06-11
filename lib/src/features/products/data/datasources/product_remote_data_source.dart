import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:food_delivery/src/features/products/data/models/category_model.dart';
import 'package:food_delivery/src/features/products/data/models/product_model.dart';

import '../../../../config/app_config.dart';
import '../../../../utils/utils.dart';

class ProductRemoteDataSource {
  ProductRemoteDataSource._();
  static final ProductRemoteDataSource instance = ProductRemoteDataSource._();

  FirebaseFirestore get _firestore => AppConfig.firestore;

  CollectionReference<Map<String, dynamic>> get _categoriesRef => _firestore.collection('categories');

  CollectionReference<Map<String, dynamic>> get _productsRef => _firestore.collection('products');

  FutureEither<List<CategoryModel>> getCategories() async {
    return runTask(() async {
      final snapshot = await _categoriesRef.get();
      return snapshot.docs.map((doc) => CategoryModel.fromMap(doc.id, doc.data())).toList();
    }, requiresNetwork: true);
  }

  FutureEither<List<ProductModel>> getProducts() async {
    return runTask(() async {
      final snapshot = await _productsRef.get();
      return snapshot.docs.map((doc) => ProductModel.fromMap(doc.id, doc.data())).toList();
    }, requiresNetwork: true);
  }

  FutureEither<List<ProductModel>> getProductsByCategory(String categoryId) async {
    return runTask(() async {
      final snapshot = await _productsRef.where('categoryId', isEqualTo: categoryId).get();
      return snapshot.docs.map((doc) => ProductModel.fromMap(doc.id, doc.data())).toList();
    }, requiresNetwork: true);
  }

  FutureEither<ProductModel> getProductById(String id) async {
    return runTask(() async {
      final doc = await _productsRef.doc(id).get();
      final data = doc.data();
      if (data == null) {
        throw Exception('Product not found');
      }
      return ProductModel.fromMap(doc.id, data);
    }, requiresNetwork: true);
  }
}
