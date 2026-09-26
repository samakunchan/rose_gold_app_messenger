import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_statics_export.dart';

class AppChipTheme {
  static final ChipThemeData chipThemeDataLight = ChipThemeData(
    backgroundColor: kLightSurfaceContainerLowestColor.withValues(alpha: 0.8),
    selectedColor: kLightPrimaryContainerColor,
    disabledColor: kLightSurfaceContainerHighestColor,
    shape: const StadiumBorder(side: BorderSide(color: Color(0xFFEFE7DC))),
    labelStyle: TextStyle(fontFamily: kFontFamily, fontSize: AppFontSize.labelMd.value, fontWeight: .w800, color: kLightPrimaryColor),
    secondaryLabelStyle: TextStyle(fontFamily: kFontFamily, fontSize: AppFontSize.labelMd.value, fontWeight: .w600, color: kEspressoTextColor),
    padding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: 0),
    showCheckmark: false,
    elevation: 0,
    pressElevation: 1,
    side: const BorderSide(color: Color(0xFFEFE7DC)),
  );

  static final ChipThemeData chipThemeDataDark = ChipThemeData(
    backgroundColor: kDarkSurfaceContainerColor.withValues(alpha: 0.8),
    selectedColor: kDarkPrimaryContainerColor,
    disabledColor: kDarkSurfaceContainerLowColor,
    shape: const StadiumBorder(side: BorderSide(color: kDarkOutlineVariantColor)),
    labelStyle: TextStyle(fontFamily: kFontFamily, fontSize: AppFontSize.labelMd.value, fontWeight: .w800, color: kDarkPrimaryColor),
    secondaryLabelStyle: TextStyle(fontFamily: kFontFamily, fontSize: AppFontSize.labelMd.value, fontWeight: .w600, color: kDarkOnSurfaceColor),
    padding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceSm.value),
    showCheckmark: false,
    elevation: 0,
    pressElevation: 1,
    side: const BorderSide(color: kDarkOutlineVariantColor),
  );
}
