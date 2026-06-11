import 'package:food_delivery/src/imports/imports.dart';

import 'package:food_delivery/src/features/cart/presentation/providers/cart_controller.dart';
import 'package:food_delivery/src/features/cart/presentation/widgets/quantity_selector.dart';
import 'package:food_delivery/src/features/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:food_delivery/src/features/products/domain/entities/product.dart';
import 'package:food_delivery/src/features/products/presentation/providers/menu_controller.dart';
import 'package:food_delivery/src/features/products/presentation/providers/product_detail_controller.dart';
import 'package:food_delivery/src/features/products/presentation/utils/product_display_helpers.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _qty = 1;
  bool _liked = false;
  int _selectedSize = 0;

  void _incrementQty() => setState(() => _qty++);

  void _decrementQty() {
    if (_qty > 1) setState(() => _qty--);
  }

  void _addToCart(Product product) {
    final cartController = Get.find<CartController>();
    cartController.addProduct(product, quantity: _qty);
    Get.find<DashboardController>().selectedIndex.value = 1;
    Get.back<void>();
  }

  String _categoryName(Product product) {
    final menu = Get.find<ProductMenuController>();
    for (final category in menu.categories) {
      if (category.id == product.categoryId) return category.name;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();

    return Scaffold(
      backgroundColor: AppColors.kBg,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(AppSpacing.sm),
          child: _CircleIconButton(
            icon: Icons.arrow_back,
            onTap: () => Get.back<void>(),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(AppSpacing.sm),
            child: _CircleIconButton(
              icon: _liked ? Icons.favorite : Icons.favorite_border,
              iconColor: _liked ? AppColors.kPrimary : AppColors.kTextDark,
              onTap: () => setState(() => _liked = !_liked),
            ),
          ),
        ],
      ),
      body: Obx(() {
        final loadedProduct = controller.product.value;
        final isLoading = loadedProduct == null;
        final product = loadedProduct ?? placeholderProduct;

        final (:rating, :estimatedTime) = productRatingAndTime(product.id);
        final categoryName = isLoading ? AppStrings.allCategories : _categoryName(product);

        return SkeletonWrapper(
          isLoading: isLoading,
          child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 260.h,
              pinned: false,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.kBg,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (product.imageUrl != null)
                      AppCachedImage(
                              imageUrl: product.imageUrl!, fit: BoxFit.cover)
                          .hero(product.id)
                    else
                      const ColoredBox(
                        color: AppColors.kInputBg,
                        child: Icon(Icons.fastfood_outlined,
                            color: AppColors.kTextGray, size: 48),
                      ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.25),
                            Colors.transparent
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.ml),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(product.name,
                              style: AppTextStyles.kHeading1),
                        ),
                        SizedBox(width: AppSpacing.sm),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: AppTextStyles.kHeading2
                              .copyWith(color: AppColors.kPrimary),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.ms),
                    Row(
                      children: [
                        const Icon(Icons.star,
                            color: AppColors.kPrimary, size: 16),
                        SizedBox(width: AppSpacing.xs),
                        Text(rating, style: AppTextStyles.kBodySmall),
                        SizedBox(width: AppSpacing.md),
                        const Icon(Icons.access_time,
                            color: AppColors.kTextGray, size: 16),
                        SizedBox(width: AppSpacing.xs),
                        Text(estimatedTime, style: AppTextStyles.kBodySmall),
                        if (categoryName.isNotEmpty) ...[
                          SizedBox(width: AppSpacing.md),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xxs),
                            decoration: const BoxDecoration(
                              color: AppColors.kLightOrange,
                              borderRadius: AppBorders.kRadiusPill,
                            ),
                            child: Text(
                              categoryName,
                              style: AppTextStyles.kCaption.copyWith(
                                color: AppColors.kPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: AppSpacing.md),
                    Text(
                      product.description,
                      style: AppTextStyles.kBodySmall.copyWith(height: 1.6),
                    ),
                    SizedBox(height: AppSpacing.md),
                    Container(
                      padding: EdgeInsets.all(AppSpacing.md),
                      decoration: const BoxDecoration(
                        color: AppColors.kCard,
                        borderRadius: AppBorders.kRadiusCard,
                        boxShadow: AppShadows.card,
                      ),
                      child: Row(
                        children: [
                          for (final (index, label) in const [
                            AppStrings.sizeRegular,
                            AppStrings.sizeLarge,
                            AppStrings.sizeFamily,
                          ].indexed) ...[
                            if (index > 0) SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedSize = index),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: AppSpacing.sm),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _selectedSize == index
                                        ? AppColors.kPrimary
                                        : AppColors.kInputBg,
                                    borderRadius: AppBorders.kRadiusInput,
                                  ),
                                  child: Text(
                                    label,
                                    style: AppTextStyles.kBodySmall.copyWith(
                                      color: _selectedSize == index
                                          ? Colors.white
                                          : AppColors.kTextDark,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        final loadedProduct = controller.product.value;
        final isLoading = loadedProduct == null;
        final product = loadedProduct ?? placeholderProduct;

        return SkeletonWrapper(
          isLoading: isLoading,
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(AppSpacing.ml),
              decoration: const BoxDecoration(
                color: AppColors.kCard,
                border: Border(top: BorderSide(color: AppColors.kInputBg)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        AppStrings.quantityLabel,
                        style: AppTextStyles.kBody.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      QuantitySelector(
                        quantity: _qty,
                        onIncrement: isLoading ? null : _incrementQty,
                        onDecrement: !isLoading && _qty > 1 ? _decrementQty : null,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.md),
                  AppButton(
                    label: '${AppStrings.addToCart}  \$${(product.price * _qty).toStringAsFixed(2)}',
                    isFullWidth: true,
                    height: ButtonSize.medium,
                    onPressed: isLoading ? null : () => _addToCart(product),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    this.iconColor = AppColors.kTextDark,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: AppColors.kCard.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          boxShadow: AppShadows.card,
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}
