import 'package:food_delivery/src/features/products/domain/entities/product.dart';
import 'package:food_delivery/src/shared/app_strings.dart';

/// A placeholder product used to render skeleton/loading UI before real
/// data has arrived.
const placeholderProduct = Product(
  id: 'placeholder',
  name: 'Sample food name',
  description:
      'This is a placeholder description shown while the real content is loading from the server.',
  price: 9.99,
  categoryId: 'placeholder',
);

/// Deterministic placeholder rating/estimated-delivery-time for a product,
/// derived from its [productId] so the same product always shows the same
/// values.
({String rating, String estimatedTime}) productRatingAndTime(String productId) {
  final seed = productId.hashCode.abs();
  final rating = (4.0 + (seed % 10) / 10).toStringAsFixed(1);
  final estimatedTime = '${15 + (seed % 4) * 5}-${25 + (seed % 4) * 5} ${AppStrings.estimatedTimeUnit}';
  return (rating: rating, estimatedTime: estimatedTime);
}
