import 'package:food_delivery/src/imports/imports.dart';

import 'package:food_delivery/src/features/orders/presentation/providers/order_detail_controller.dart';
import 'package:food_delivery/src/features/orders/presentation/utils/order_display_helpers.dart';
import 'package:food_delivery/src/features/orders/presentation/widgets/eta_card.dart';
import 'package:food_delivery/src/features/orders/presentation/widgets/map_placeholder.dart';
import 'package:food_delivery/src/features/orders/presentation/widgets/order_items_card.dart';
import 'package:food_delivery/src/features/orders/presentation/widgets/tracking_step.dart';
import 'package:get/get.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  void _onCallDriver() {
    showGlobalToast(message: AppStrings.callDriverComingSoon, status: 'info');
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderDetailController>();

    return Scaffold(
      backgroundColor: AppColors.kBg,
      appBar: AppBar(
        backgroundColor: AppColors.kCard,
        elevation: 0,
        title: Obx(() {
          final order = controller.order.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(AppStrings.trackOrderTitle, style: AppTextStyles.kHeading2),
              if (order != null)
                Text(
                  '${AppStrings.orderNumberPrefix}${formatOrderNumber(order.id)}',
                  style: AppTextStyles.kCaption,
                ),
            ],
          );
        }),
      ),
      body: Obx(() {
        final order = controller.order.value;
        if (order == null) {
          return const AppLoading();
        }

        final stepIndex = trackingStepIndex(order.status);
        final steps = [
          (
            label: AppStrings.stepOrderPlacedLabel,
            sublabel: AppStrings.stepOrderPlacedSublabel,
            time: formatOrderTime(order.createdAt),
          ),
          (
            label: AppStrings.stepPreparingLabel,
            sublabel: AppStrings.stepPreparingSublabel,
            time: formatOrderTime(order.createdAt.add(const Duration(minutes: 5))),
          ),
          (
            label: AppStrings.stepOutForDeliveryLabel,
            sublabel: AppStrings.stepOutForDeliverySublabel,
            time: formatOrderTime(order.createdAt.add(const Duration(minutes: 25))),
          ),
          (
            label: AppStrings.stepDeliveredLabel,
            sublabel: AppStrings.stepDeliveredSublabel,
            time: '',
          ),
        ];

        return SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MapPlaceholder(),
              SizedBox(height: AppSpacing.md),
              EtaCard(onCallDriver: _onCallDriver),
              SizedBox(height: AppSpacing.md),
              Container(
                padding: EdgeInsets.all(AppSpacing.md),
                decoration: const BoxDecoration(
                  color: AppColors.kCard,
                  borderRadius: AppBorders.kRadiusCard,
                  boxShadow: AppShadows.card,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(AppStrings.orderStatusTitle, style: AppTextStyles.kHeading3),
                    SizedBox(height: AppSpacing.sm),
                    for (var i = 0; i < steps.length; i++)
                      TrackingStep(
                        label: steps[i].label,
                        sublabel: steps[i].sublabel,
                        time: i <= stepIndex ? steps[i].time : '',
                        isDone: i < stepIndex,
                        isCurrent: i == stepIndex,
                        isLast: i == steps.length - 1,
                      ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.md),
              OrderItemsCard(items: order.items),
            ],
          ),
        );
      }),
    );
  }
}
