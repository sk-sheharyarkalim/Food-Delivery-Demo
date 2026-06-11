import 'package:flutter/material.dart';

/// The complete color palette for the app, taken directly from the design
/// reference. These are the only colors that should be used throughout the
/// app's (light) UI.
abstract final class AppColors {
  AppColors._();

  /// Primary brand color — orange.
  static const Color kPrimary = Color(0xFFFF6B35);

  /// Pressed/active state for primary elements — darker orange.
  static const Color kPressed = Color(0xFFD84315);

  /// Success/confirmation color — green.
  static const Color kSuccess = Color(0xFF2E9E5B);

  /// Primary text color.
  static const Color kTextDark = Color(0xFF1A1A1A);

  /// Secondary/muted text color.
  static const Color kTextGray = Color(0xFF717182);

  /// App background color.
  static const Color kBg = Color(0xFFFAFAFA);

  /// Card/surface background color.
  static const Color kCard = Color(0xFFFFFFFF);

  /// Light orange tint — used for primary containers/badges.
  static const Color kLightOrange = Color(0xFFFFF3EE);

  /// Light green tint — used for success containers/badges.
  static const Color kLightGreen = Color(0xFFEDF7F2);

  /// Background color for input fields.
  static const Color kInputBg = Color(0xFFF5F5F5);

  /// Map placeholder background — light teal.
  static const Color kMapBg = Color(0xFFE8F4F0);

  /// Divider/line color for pending states (e.g. tracking timeline).
  static const Color kDivider = Color(0xFFE5E5E5);
}
