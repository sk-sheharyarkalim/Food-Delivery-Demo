import 'package:food_delivery/src/imports/imports.dart';

import 'package:food_delivery/src/features/products/domain/entities/product.dart';
import 'package:food_delivery/src/features/products/presentation/utils/product_display_helpers.dart';

/// A grid card for a single [Product]: image, name, rating/time row, price
/// and an "add to cart" button.
class FoodCard extends StatelessWidget {
  const FoodCard({
    super.key,
    required this.product,
    this.onTap,
    this.onAdd,
  });

  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    final (:rating, :estimatedTime) = productRatingAndTime(product.id);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.kCard,
          borderRadius: AppBorders.kRadiusCard,
          boxShadow: AppShadows.card,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.imageUrl != null)
              AppCachedImage(
                imageUrl: product.imageUrl!,
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            else
              Container(
                height: 110.h,
                width: double.infinity,
                color: AppColors.kInputBg,
                child: const Icon(Icons.fastfood_outlined, color: AppColors.kTextGray),
              ),
            Padding(
              padding: EdgeInsets.all(AppSpacing.ms),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.kBodySmall.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kTextDark,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xxs),
                  Row(
                    children: [
                      const Icon(Icons.star, color: AppColors.kPrimary, size: 11),
                      SizedBox(width: AppSpacing.xxs),
                      Text(rating, style: AppTextStyles.kCaption),
                      const Text(' · ', style: AppTextStyles.kCaption),
                      Expanded(
                        child: Text(
                          estimatedTime,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.kCaption,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Text('\$${product.price.toStringAsFixed(2)}', style: AppTextStyles.kPrice),
                      const Spacer(),
                      GestureDetector(
                        onTap: onAdd,
                        child: Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: const BoxDecoration(
                            color: AppColors.kPrimary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
