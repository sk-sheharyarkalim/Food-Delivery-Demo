import 'package:food_delivery/src/features/products/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.categoryId,
    super.imageUrl,
    super.isAvailable,
  });

  factory ProductModel.fromMap(String id, Map<String, dynamic> map) => ProductModel(
        id: id,
        name: map['name'] as String? ?? '',
        description: map['description'] as String? ?? '',
        price: (map['price'] as num?)?.toDouble() ?? 0.0,
        categoryId: map['categoryId'] as String? ?? '',
        imageUrl: map['imageUrl'] as String?,
        isAvailable: map['isAvailable'] as bool? ?? true,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'description': description,
        'price': price,
        'categoryId': categoryId,
        'imageUrl': imageUrl,
        'isAvailable': isAvailable,
      };

  Product toEntity() => Product(
        id: id,
        name: name,
        description: description,
        price: price,
        categoryId: categoryId,
        imageUrl: imageUrl,
        isAvailable: isAvailable,
      );
}
