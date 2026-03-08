import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color primary = Color(0xFF0E7490);
  static const Color primaryLight = Color(0xFF0891B2);
  static const Color primaryContainer = Color(0xFFCFFAFE);
  static const Color onPrimary = Color(0xFFFFFFFF);

  static const Color secondary = Color(0xFFF97316);
  static const Color secondaryContainer = Color(0xFFFFEDD5);
  static const Color onSecondary = Color(0xFFFFFFFF);

  static const Color background = Color(0xFFF9FAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF3F4F6);
  static const Color onBackground = Color(0xFF111827);
  static const Color onSurface = Color(0xFF111827);
  static const Color onSurfaceVariant = Color(0xFF6B7280);

  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFE5E7EB);

  static const Color success = Color(0xFF16A34A);
  static const Color successContainer = Color(0xFFDCFCE7);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFDC2626);
  static const Color errorContainer = Color(0xFFFEE2E2);

  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);

  static const Color iconPrimary = Color(0xFF374151);
  static const Color iconSecondary = Color(0xFF9CA3AF);

  static const Color ocean600 = primary;
  static const Color ocean500 = primaryLight;
  static const Color ocean100 = primaryContainer;

  static const Color coral500 = secondary;
  static const Color ink900 = textPrimary;
  static const Color ink700 = Color(0xFF374151);
  static const Color slate500 = textSecondary;
  static const Color mist100 = surfaceVariant;
  static const Color paper = surface;

  @Deprecated('Use primary instead')
  static const Color success500 = success;
  @Deprecated('Use warning instead')
  static const Color warning500 = warning;
  @Deprecated('Use error instead')
  static const Color danger500 = error;
}
