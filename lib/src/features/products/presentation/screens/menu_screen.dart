import 'package:food_delivery/src/imports/imports.dart';

import 'package:food_delivery/src/features/products/presentation/providers/menu_controller.dart';
import 'package:food_delivery/src/features/products/presentation/widgets/category_pill.dart';
import 'package:food_delivery/src/features/products/presentation/widgets/food_card.dart';
import 'package:food_delivery/src/features/products/presentation/widgets/promo_banner.dart';
import 'package:food_delivery/src/features/products/presentation/utils/product_display_helpers.dart';
import 'package:food_delivery/src/features/notifications/presentation/providers/notification_controller.dart';
import 'package:get/get.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductMenuController>();
    return Scaffold(
      backgroundColor: AppColors.kBg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              primary: false,
              floating: true,
              snap: true,
              pinned: false,
              toolbarHeight: 168.h,
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.kCard,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: AppColors.kPrimary, size: 16),
                                  SizedBox(width: AppSpacing.xxs),
                                  const Text(AppStrings.deliveringTo,
                                      style: AppTextStyles.kCaption),
                                ],
                              ),
                              SizedBox(height: AppSpacing.xxs),
                              Text(
                                AppStrings.defaultAddress,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.kBody
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Get.toNamed<void>(AppRoutes.notifications),
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: const BoxDecoration(
                              color: AppColors.kInputBg,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Obx(() {
                                final unreadCount = Get.find<NotificationController>().unreadCount;
                                return Badge(
                                  backgroundColor: AppColors.kPrimary,
                                  textColor: Colors.white,
                                  label: Text('$unreadCount'),
                                  isLabelVisible: unreadCount > 0,
                                  child: const Icon(Icons.notifications_outlined,
                                      color: AppColors.kTextDark),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.ms),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Container(
                      height: 48.h,
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      decoration: const BoxDecoration(
                        color: AppColors.kInputBg,
                        borderRadius: AppBorders.kRadiusPill,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search,
                              color: AppColors.kTextGray, size: 20),
                          SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) =>
                                  controller.searchQuery.value = value,
                              style: AppTextStyles.kBody,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                hintText: AppStrings.searchHint,
                                hintStyle: AppTextStyles.kBodySmall,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                isCollapsed: true,
                              ),
                            ),
                          ),
                          ValueListenableBuilder<TextEditingValue>(
                            valueListenable: _searchController,
                            builder: (context, value, _) {
                              if (value.text.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return GestureDetector(
                                onTap: () {
                                  _searchController.clear();
                                  controller.searchQuery.value = '';
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Icon(Icons.close,
                                      color: AppColors.kTextGray, size: 18),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.ms),
                  SizedBox(
                    height: 36.h,
                    child: Obx(
                      () => ListView(
                        scrollDirection: Axis.horizontal,
                        padding:
                            EdgeInsets.symmetric(horizontal: AppSpacing.md),
                        children: [
                          CategoryPill(
                            label: AppStrings.allCategories,
                            isActive:
                                controller.selectedCategoryId.value == null,
                            onTap: () => controller.selectCategory(null),
                          ),
                          for (final category in controller.categories) ...[
                            SizedBox(width: AppSpacing.sm),
                            CategoryPill(
                              label: category.name,
                              isActive: controller.selectedCategoryId.value ==
                                  category.id,
                              onTap: () =>
                                  controller.selectCategory(category.id),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(AppSpacing.md),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const PromoBanner(),
                  SizedBox(height: AppSpacing.lg),
                  const Text(AppStrings.popularNearYou,
                      style: AppTextStyles.kHeading3),
                  SizedBox(height: AppSpacing.ms),
                ]),
              ),
            ),
            Obx(() {
              final isLoading = controller.status.value == AppStatus.loading &&
                  controller.products.isEmpty;
              final items = isLoading
                  ? List.filled(6, placeholderProduct)
                  : controller.filteredProducts;

              return SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSpacing.ms,
                    crossAxisSpacing: AppSpacing.ms,
                    childAspectRatio: 0.7,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = items[index];

                      return SkeletonWrapper(
                        isLoading: isLoading,
                        child: FoodCard(
                          product: product,
                          onTap: isLoading
                              ? null
                              : () => Get.toNamed<void>(AppRoutes.productDetail,
                                  arguments: product.id),
                          onAdd: isLoading
                              ? null
                              : () => Get.toNamed<void>(AppRoutes.productDetail,
                                  arguments: product.id),
                        ).hero(isLoading ? '${product.id}-$index' : product.id),
                      );
                    },
                    childCount: items.length,
                  ),
                ),
              );
            }),
            SliverPadding(padding: EdgeInsets.only(bottom: AppSpacing.lg)),
          ],
        ),
      ),
    );
  }
}
