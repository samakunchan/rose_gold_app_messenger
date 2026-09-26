import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_statics_export.dart';

class AppAppBarTheme {
  static final AppBarTheme lightAppBarTheme = AppBarTheme(
    backgroundColor: kLightSurfaceColor.withValues(alpha: 0.9),
    surfaceTintColor: Colors.transparent,
    shadowColor: kEspressoDarkTextColor.withValues(alpha: 0.05),
    elevation: 0,
    scrolledUnderElevation: 1,
    centerTitle: true,
    iconTheme: const IconThemeData(color: kLightPrimaryColor, size: 22),
    actionsIconTheme: const IconThemeData(color: kChampagneGoldColor, size: 22),
    titleTextStyle: TextStyle(
      fontFamily: kFontFamily,
      fontSize: AppFontSize.headlineSm.value,
      fontWeight: .w600,
      letterSpacing: -0.18,
      color: kLightOnSurfaceColor,
    ),
  );

  static final AppBarTheme darkAppBarTheme = AppBarTheme(
    backgroundColor: kDarkSurfaceColor.withValues(alpha: 0.9),
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.black.withValues(alpha: 0.3),
    elevation: 0,
    scrolledUnderElevation: 1,
    centerTitle: true,
    iconTheme: const IconThemeData(color: kDarkPrimaryColor, size: 22),
    actionsIconTheme: const IconThemeData(color: kDarkSecondaryColor, size: 22),
    titleTextStyle: TextStyle(
      fontFamily: kFontFamily,
      fontSize: AppFontSize.headlineSm.value,
      fontWeight: .w600,
      letterSpacing: -0.18,
      color: kDarkOnSurfaceColor,
    ),
  );
}
