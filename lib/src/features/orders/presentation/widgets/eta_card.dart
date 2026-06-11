import 'package:food_delivery/src/imports/imports.dart';

/// Shows the estimated arrival time and driver info with a call action.
class EtaCard extends StatelessWidget {
  const EtaCard({super.key, this.onCallDriver});

  final VoidCallback? onCallDriver;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.kPrimary,
        borderRadius: AppBorders.kRadiusCard,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.estimatedArrivalLabel, style: AppTextStyles.kCaption.copyWith(color: Colors.white70)),
              SizedBox(height: AppSpacing.xxs),
              const Text(
                AppStrings.estimatedArrivalValue,
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(AppStrings.driverLabel, style: AppTextStyles.kCaption.copyWith(color: Colors.white70)),
                  const Text(
                    AppStrings.driverName,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(width: AppSpacing.sm),
              GestureDetector(
                onTap: onCallDriver,
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.call, color: AppColors.kPrimary, size: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
