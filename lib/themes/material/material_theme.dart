import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class MaterialTheme {
  static ThemeData get light => getMaterialTheme(.light);
  static ThemeData get dark => getMaterialTheme(.dark);

  static final ThemeData materialLightTheme = ThemeData(
    useMaterial3: true,
    brightness: .light,
    primaryColor: kLightPrimaryColor,
    scaffoldBackgroundColor: kLightBaseCanvasColor,
    fontFamily: kFontFamily,
    colorScheme: const ColorScheme.light(
      primary: kLightPrimaryColor,
      // onPrimary: kLightOnPrimaryColor,
      primaryContainer: kLightPrimaryContainerColor,
      onPrimaryContainer: kLightOnPrimaryContainerColor,
      inversePrimary: kLightInversePrimaryColor,
      secondary: kLightSecondaryColor,
      onSecondary: kLightOnSecondaryColor,
      secondaryContainer: kLightSecondaryContainerColor,
      onSecondaryContainer: kLightOnSecondaryContainerColor,
      tertiary: kLightTertiaryColor,
      onTertiary: kLightOnTertiaryColor,
      tertiaryContainer: kLightTertiaryContainerColor,
      onTertiaryContainer: kLightOnTertiaryContainerColor,
      error: kLightErrorColor,
      // onError: kLightOnErrorColor,
      errorContainer: kLightErrorContainerColor,
      onErrorContainer: kLightOnErrorContainerColor,
      surface: kLightSurfaceColor,
      onSurface: kLightOnSurfaceColor,
      onSurfaceVariant: kLightOnSurfaceVariantColor,
      outline: kLightOutlineColor,
      outlineVariant: kLightOutlineVariantColor,
      inverseSurface: kLightInverseSurfaceColor,
      onInverseSurface: kLightInverseOnSurfaceColor,
      surfaceTint: kLightSurfaceTintColor,
    ),
    iconTheme: const IconThemeData(color: kLightPrimaryColor),
    elevatedButtonTheme: AppButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: AppButtonTheme.lightOutlinedButtonTheme,
    textButtonTheme: AppButtonTheme.textButtonThemeLight,
    iconButtonTheme: AppButtonTheme.iconButtonThemeLight,
    filledButtonTheme: AppButtonTheme.filledButtonThemeLight,
    segmentedButtonTheme: AppButtonTheme.lightSegmentedButtonTheme,
    // floatingActionButtonTheme: AppButtonTheme.lightSegmentedButtonTheme,
    chipTheme: AppChipTheme.chipThemeDataLight,
    dialogTheme: AppDialogTheme.lightDialogTheme,
    bottomSheetTheme: AppDialogTheme.lightBottomSheetTheme,
    cardTheme: AppCardTheme.lightCardTheme,
    appBarTheme: AppAppBarTheme.lightAppBarTheme,
    inputDecorationTheme: AppInputDecorationTheme.lightInputDecorationTheme,
    dividerTheme: const DividerThemeData(space: 1, thickness: 0.5, color: kHairlineDividerColor),
    badgeTheme: const BadgeThemeData(backgroundColor: kLightSecondaryContainerColor, textColor: kLightOnSecondaryContainerColor),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: kLightPrimaryContainerColor),
    extensions: <ThemeExtension<dynamic>>[ChatThemeExtension.light, FrontThemeExtension.light],
  );

  static final ThemeData materialDarkTheme = ThemeData(
    useMaterial3: true,
    brightness: .dark,
    primaryColor: kDarkPrimaryColor,
    scaffoldBackgroundColor: kDarkBackgroundColor,
    fontFamily: kFontFamily,
    colorScheme: const ColorScheme.dark(
      primary: kDarkPrimaryColor,
      onPrimary: kDarkOnPrimaryColor,
      primaryContainer: kDarkPrimaryContainerColor,
      onPrimaryContainer: kDarkOnPrimaryContainerColor,
      inversePrimary: kLightPrimaryContainerColor,
      secondary: kDarkSecondaryColor,
      onSecondary: kDarkOnSecondaryColor,
      secondaryContainer: kDarkSecondaryContainerColor,
      onSecondaryContainer: kDarkOnSecondaryContainerColor,
      tertiary: kDarkTertiaryColor,
      onTertiary: kDarkOnTertiaryColor,
      tertiaryContainer: kDarkTertiaryContainerColor,
      onTertiaryContainer: kDarkOnTertiaryContainerColor,
      error: kDarkErrorColor,
      onError: kDarkOnErrorColor,
      errorContainer: kDarkErrorContainerColor,
      onErrorContainer: kDarkOnErrorContainerColor,
      surface: kDarkSurfaceColor,
      onSurface: kDarkOnSurfaceColor,
      onSurfaceVariant: kDarkOnSurfaceVariantColor,
      outline: kDarkOutlineColor,
      outlineVariant: kDarkOutlineVariantColor,
      inverseSurface: kDarkInverseSurfaceColor,
      onInverseSurface: kDarkInverseOnSurfaceColor,
      surfaceTint: kDarkSurfaceTintColor,
    ),
    iconTheme: const IconThemeData(color: kDarkPrimaryColor),
    elevatedButtonTheme: AppButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: AppButtonTheme.darkOutlinedButtonTheme,
    textButtonTheme: AppButtonTheme.textButtonThemeDark,
    iconButtonTheme: AppButtonTheme.iconButtonThemeDark,
    filledButtonTheme: AppButtonTheme.filledButtonThemeDark,
    segmentedButtonTheme: AppButtonTheme.darkSegmentedButtonTheme,
    chipTheme: AppChipTheme.chipThemeDataDark,
    dialogTheme: AppDialogTheme.darkDialogTheme,
    bottomSheetTheme: AppDialogTheme.darkBottomSheetTheme,
    cardTheme: AppCardTheme.darkCardTheme,
    appBarTheme: AppAppBarTheme.darkAppBarTheme,
    inputDecorationTheme: AppInputDecorationTheme.darkInputDecorationTheme,
    dividerTheme: const DividerThemeData(space: 1, thickness: 0.5, color: kDarkHairlineDividerColor),
    badgeTheme: const BadgeThemeData(backgroundColor: kDarkSecondaryContainerColor, textColor: kDarkOnSecondaryContainerColor),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: kDarkPrimaryColor),
    extensions: <ThemeExtension<dynamic>>[ChatThemeExtension.dark, FrontThemeExtension.dark],
  );

  static ThemeData getMaterialTheme(Brightness brightness, {String? fontFamily, double fontSizeMultiplier = 1.0}) {
    final String? resolvedFontFamily = fontFamily == 'System' ? null : fontFamily;
    final bool isDark = brightness == .dark;
    final ThemeData baseTheme = isDark ? materialDarkTheme : materialLightTheme;

    final TextTheme baseTextTheme = AppTextTheme.getDefaultTextTheme(brightness);
    final TextTheme scaledTextTheme = AppTextTheme.getScaledTextTheme(
      baseTextTheme,
      resolvedFontFamily,
      fontSizeMultiplier,
      baseTheme.colorScheme,
    );

    return baseTheme.copyWith(textTheme: scaledTextTheme);
  }
}
