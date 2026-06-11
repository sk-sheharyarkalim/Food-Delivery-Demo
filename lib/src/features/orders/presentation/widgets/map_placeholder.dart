import 'dart:math' as math;

import 'package:food_delivery/src/imports/imports.dart';

/// A static map preview showing a dashed delivery route, the destination
/// pin and the driver's current position.
class MapPlaceholder extends StatelessWidget {
  const MapPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: AppColors.kMapBg,
        borderRadius: AppBorders.kRadiusCard,
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _DashedRoutePainter())),
          Positioned(
            top: AppSpacing.md,
            right: AppSpacing.md,
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: const BoxDecoration(color: AppColors.kPrimary, shape: BoxShape.circle),
              child: const Icon(Icons.location_on, color: Colors.white, size: 20),
            ),
          ),
          Positioned(
            left: AppSpacing.xl,
            bottom: AppSpacing.xl,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppColors.kPrimary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: AppColors.kPrimary.withValues(alpha: 0.4), blurRadius: 12, spreadRadius: 4),
                ],
              ),
              child: const Center(child: Text('🛵', style: TextStyle(fontSize: 18))),
            ),
          ),
          Positioned(
            right: AppSpacing.sm,
            bottom: AppSpacing.sm,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: AppBorders.sm,
              ),
              child: const Text(AppStrings.liveMapPreview, style: AppTextStyles.kCaption),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedRoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.kPrimary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width * 0.18, size.height * 0.78)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.15,
        size.width * 0.85,
        size.height * 0.22,
      );

    const dashWidth = 6.0;
    const dashSpace = 5.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final length = math.min(dashWidth, metric.length - distance);
        canvas.drawPath(metric.extractPath(distance, distance + length), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedRoutePainter oldDelegate) => false;
}
