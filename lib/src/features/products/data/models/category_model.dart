import 'package:food_delivery/src/features/products/domain/entities/category.dart';

class CategoryModel extends ProductCategory {
  const CategoryModel({
    required super.id,
    required super.name,
    super.imageUrl,
  });

  factory CategoryModel.fromMap(String id, Map<String, dynamic> map) => CategoryModel(
        id: id,
        name: map['name'] as String? ?? '',
        imageUrl: map['imageUrl'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'imageUrl': imageUrl,
      };

  ProductCategory toEntity() => ProductCategory(id: id, name: name, imageUrl: imageUrl);
}
