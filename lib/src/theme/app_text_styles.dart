import 'package:flutter/material.dart';

import 'app_colors.dart';

/// The complete text style palette for the app, taken directly from the
/// design reference. These are the only text styles that should be used
/// throughout the app's (light) UI.
abstract final class AppTextStyles {
  AppTextStyles._();

  /// 22 / w700 — primary page-level heading.
  static const TextStyle kHeading1 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.kTextDark,
  );

  /// 20 / w700 — secondary heading.
  static const TextStyle kHeading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.kTextDark,
  );

  /// 17 / w700 — tertiary heading / section title.
  static const TextStyle kHeading3 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.kTextDark,
  );

  /// 14 / w400 — default body text.
  static const TextStyle kBody = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.kTextDark,
  );

  /// 13 / w400 — secondary body text.
  static const TextStyle kBodySmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.kTextGray,
  );

  /// 12 / w400 — captions, metadata, timestamps.
  static const TextStyle kCaption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.kTextGray,
  );

  /// 14 / w700 — prices, highlighted primary-colored values.
  static const TextStyle kPrice = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.kPrimary,
  );
}
