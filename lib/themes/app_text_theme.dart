import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_statics_export.dart';

class AppTextTheme {
  static TextTheme getDefaultTextTheme(Brightness brightness) {
    final Typography typography = Typography.material2021();
    return brightness == .dark ? typography.white : typography.black;
  }

  static TextTheme getScaledTextTheme(TextTheme base, String? fontFamily, double multiplier, ColorScheme colorScheme) {
    final String resolvedFontFamily = fontFamily ?? kFontFamily;

    return TextTheme(
      // display-lg (36px / 44px, w600, -0.02em)
      displayLarge: applyScale(base.displayLarge, resolvedFontFamily, multiplier, AppFontSize.displayLg.value)?.copyWith(
        fontWeight: .w600,
        height: 44 / AppFontSize.displayLg.value,
        letterSpacing: -0.02 * AppFontSize.displayLg.value,
        color: colorScheme.onSurface,
      ),

      // display-lg-mobile / displayMedium (28px / 34px, w600, -0.02em)
      displayMedium: applyScale(base.displayMedium, resolvedFontFamily, multiplier, AppFontSize.displayMd.value)?.copyWith(
        fontWeight: .w600,
        height: 34 / AppFontSize.displayMd.value,
        letterSpacing: -0.02 * AppFontSize.displayMd.value,
        color: colorScheme.onSurface,
      ),

      // displaySmall (26px, w600)
      displaySmall: applyScale(base.displaySmall, resolvedFontFamily, multiplier, AppFontSize.displaySm.value)?.copyWith(
        fontWeight: .w600,
        color: colorScheme.onSurface,
      ),

      // headline-lg (24px / 32px, w600, -0.015em)
      headlineLarge: applyScale(base.headlineLarge, resolvedFontFamily, multiplier, AppFontSize.headlineLg.value)?.copyWith(
        fontWeight: .w600,
        height: 32 / AppFontSize.headlineLg.value,
        letterSpacing: -0.015 * AppFontSize.headlineLg.value,
        color: colorScheme.onSurface,
      ),

      // headline-md (20px / 28px, w600, -0.01em)
      headlineMedium: applyScale(base.headlineMedium, resolvedFontFamily, multiplier, AppFontSize.headlineMd.value)?.copyWith(
        fontWeight: .w600,
        height: 28 / AppFontSize.headlineMd.value,
        letterSpacing: -0.01 * AppFontSize.headlineMd.value,
        color: colorScheme.onSurface,
      ),

      // headline-sm (18px / 26px, w500, 0em)
      headlineSmall: applyScale(base.headlineSmall, resolvedFontFamily, multiplier, AppFontSize.headlineSm.value)?.copyWith(
        fontWeight: .w500,
        height: 26 / AppFontSize.headlineSm.value,
        letterSpacing: 0,
        color: colorScheme.onSurface,
      ),

      // titleLarge
      titleLarge: applyScale(base.titleLarge, resolvedFontFamily, multiplier, AppFontSize.titleLg.value)?.copyWith(
        fontWeight: .w600,
        color: colorScheme.onSurface,
      ),

      // titleMedium
      titleMedium: applyScale(base.titleMedium, resolvedFontFamily, multiplier, AppFontSize.titleMd.value)?.copyWith(
        fontWeight: .w600,
        color: colorScheme.onSurface,
      ),

      // titleSmall
      titleSmall: applyScale(base.titleSmall, resolvedFontFamily, multiplier, AppFontSize.titleSm.value)?.copyWith(
        fontWeight: .w500,
        color: colorScheme.onSurfaceVariant,
      ),

      // body-lg (16px / 24px, w400, 0em)
      bodyLarge: applyScale(base.bodyLarge, resolvedFontFamily, multiplier, AppFontSize.bodyLg.value)?.copyWith(
        fontWeight: .w400,
        height: 24 / AppFontSize.bodyLg.value,
        letterSpacing: 0,
        color: colorScheme.onSurface,
      ),

      // body-md (14px / 20px, w400, 0.005em)
      bodyMedium: applyScale(base.bodyMedium, resolvedFontFamily, multiplier, AppFontSize.bodyMd.value)?.copyWith(
        fontWeight: .w400,
        height: 20 / AppFontSize.bodyMd.value,
        letterSpacing: 0.005 * AppFontSize.bodyMd.value,
        color: colorScheme.onSurface,
      ),

      // body-sm (13px / 18px, w400, 0.01em)
      bodySmall: applyScale(base.bodySmall, resolvedFontFamily, multiplier, AppFontSize.bodySm.value)?.copyWith(
        fontWeight: .w400,
        height: 18 / AppFontSize.bodySm.value,
        letterSpacing: 0.01 * AppFontSize.bodySm.value,
        color: colorScheme.onSurfaceVariant,
      ),

      // label-lg (14px / 20px, w600, 0.02em)
      labelLarge: applyScale(base.labelLarge, resolvedFontFamily, multiplier, AppFontSize.labelLg.value)?.copyWith(
        fontWeight: .w600,
        height: 20 / AppFontSize.labelLg.value,
        letterSpacing: 0.02 * AppFontSize.labelLg.value,
        color: colorScheme.onSurface,
      ),

      // label-md (12px / 16px, w600, 0.03em)
      labelMedium: applyScale(base.labelMedium, resolvedFontFamily, multiplier, AppFontSize.labelMd.value)?.copyWith(
        fontWeight: .w600,
        height: 16 / AppFontSize.labelMd.value,
        letterSpacing: 0.03 * AppFontSize.labelMd.value,
        color: colorScheme.onSurfaceVariant,
      ),

      // label-sm (11px / 14px, w500, 0.04em)
      labelSmall: applyScale(base.labelSmall, resolvedFontFamily, multiplier, AppFontSize.labelSm.value)?.copyWith(
        fontWeight: .w500,
        height: 14 / AppFontSize.labelSm.value,
        letterSpacing: 0.04 * AppFontSize.labelSm.value,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  static TextStyle? applyScale(TextStyle? style, String? fontFamily, double multiplier, double defaultSize) {
    if (style == null) return null;
    final double fontSize = style.fontSize ?? defaultSize;
    return style.copyWith(
      fontFamily: fontFamily,
      fontSize: fontSize * multiplier,
    );
  }

  /// Caption micro-label style (10px / 12px, w500, 0.06em)
  static TextStyle captionStyle({required Color color, String? fontFamily, double multiplier = 1}) {
    return TextStyle(
      fontFamily: fontFamily ?? kFontFamily,
      fontSize: AppFontSize.caption.value * multiplier,
      fontWeight: .w500,
      height: 12 / AppFontSize.caption.value,
      letterSpacing: 0.06 * AppFontSize.caption.value,
      color: color,
    );
  }
}
