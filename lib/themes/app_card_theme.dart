import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_statics_export.dart';

class AppCardTheme {
  static final CardThemeData lightCardTheme = CardThemeData(
    color: kLightSurfaceContainerLowestColor,
    surfaceTintColor: Colors.transparent,
    elevation: 2,
    shadowColor: kEspressoDarkTextColor.withValues(alpha: 0.05),
    shape: RoundedRectangleBorder(
      borderRadius: .all(.circular(AppRadius.defaultValue.value)),
      side: const BorderSide(color: kDelicateGoldBorderColor, width: 0.5),
    ),
    margin: .zero,
    clipBehavior: .antiAlias,
  );

  static final CardThemeData darkCardTheme = CardThemeData(
    color: kDarkSurfaceContainerColor,
    surfaceTintColor: Colors.transparent,
    elevation: 2,
    shadowColor: Colors.black.withValues(alpha: 0.3),
    shape: RoundedRectangleBorder(
      borderRadius: .all(.circular(AppRadius.defaultValue.value)),
      side: const BorderSide(color: kDarkDelicateGoldBorderColor, width: 0.5),
    ),
    margin: .zero,
    clipBehavior: .antiAlias,
  );
}
