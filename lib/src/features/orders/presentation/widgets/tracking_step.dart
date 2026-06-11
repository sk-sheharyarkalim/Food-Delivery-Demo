import 'package:food_delivery/src/imports/imports.dart';

/// A single row in the order status timeline.
class TrackingStep extends StatelessWidget {
  const TrackingStep({
    super.key,
    required this.label,
    required this.sublabel,
    required this.time,
    required this.isDone,
    required this.isCurrent,
    required this.isLast,
  });

  final String label;
  final String sublabel;
  final String time;
  final bool isDone;
  final bool isCurrent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StepIndicator(isDone: isDone, isCurrent: isCurrent, isLast: isLast),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(label, style: AppTextStyles.kBody.copyWith(fontWeight: FontWeight.w600)),
                      if (time.isNotEmpty) Text(time, style: AppTextStyles.kCaption),
                    ],
                  ),
                  SizedBox(height: AppSpacing.xxs),
                  Text(sublabel, style: AppTextStyles.kBodySmall),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({
    required this.isDone,
    required this.isCurrent,
    required this.isLast,
  });

  final bool isDone;
  final bool isCurrent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDone || isCurrent ? AppColors.kPrimary : AppColors.kInputBg,
            border: isCurrent
                ? Border.all(color: AppColors.kPrimary.withValues(alpha: 0.25), width: 4)
                : null,
          ),
          child: Center(
            child: switch ((isDone, isCurrent)) {
              (true, _) => const Icon(Icons.check, color: Colors.white, size: 16),
              (_, true) => Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                ),
              _ => Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(color: AppColors.kTextGray, shape: BoxShape.circle),
                ),
            },
          ),
        ),
        if (!isLast)
          Expanded(
            child: Container(
              width: 2,
              margin: EdgeInsets.symmetric(vertical: AppSpacing.xs),
              color: isDone ? AppColors.kPrimary : AppColors.kDivider,
            ),
          ),
      ],
    );
  }
}
