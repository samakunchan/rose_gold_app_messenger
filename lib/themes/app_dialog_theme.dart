import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_statics_export.dart';

class AppDialogTheme {
  static final DialogThemeData lightDialogTheme = DialogThemeData(
    elevation: 8,
    backgroundColor: kLightSurfaceContainerLowestColor,
    surfaceTintColor: Colors.transparent,
    shadowColor: kEspressoTextColor.withValues(alpha: 0.08),
    shape: RoundedRectangleBorder(
      borderRadius: .all(.circular(AppRadius.dialog.value)),
      side: const BorderSide(color: kModalChampagneRimColor),
    ),
    titleTextStyle: TextStyle(fontFamily: kFontFamily, fontSize: AppFontSize.headlineMd.value, fontWeight: .w600, color: kLightOnSurfaceColor),
    contentTextStyle: TextStyle(
      fontFamily: kFontFamily,
      fontSize: AppFontSize.bodyMd.value,
      fontWeight: .w400,
      color: kLightOnSurfaceVariantColor,
    ),
  );

  static final DialogThemeData darkDialogTheme = DialogThemeData(
    elevation: 8,
    backgroundColor: kDarkSurfaceContainerColor,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.black.withValues(alpha: 0.4),
    shape: RoundedRectangleBorder(
      borderRadius: .all(.circular(AppRadius.dialog.value)),
      side: const BorderSide(color: kDarkDelicateGoldBorderColor),
    ),
    titleTextStyle: TextStyle(fontFamily: kFontFamily, fontSize: AppFontSize.headlineMd.value, fontWeight: .w600, color: kDarkOnSurfaceColor),
    contentTextStyle: TextStyle(
      fontFamily: kFontFamily,
      fontSize: AppFontSize.bodyMd.value,
      fontWeight: .w400,
      color: kDarkOnSurfaceVariantColor,
    ),
  );

  static final BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    backgroundColor: kLightSurfaceContainerLowestColor,
    surfaceTintColor: Colors.transparent,
    elevation: 12,
    shadowColor: kEspressoTextColor.withValues(alpha: 0.08),
    shape: RoundedRectangleBorder(
      borderRadius: .vertical(top: .circular(AppRadius.dialog.value)),
      side: const BorderSide(color: kModalChampagneRimColor),
    ),
    clipBehavior: .antiAlias,
  );

  static final BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    backgroundColor: kDarkSurfaceContainerColor,
    surfaceTintColor: Colors.transparent,
    elevation: 12,
    shadowColor: Colors.black.withValues(alpha: 0.4),
    shape: RoundedRectangleBorder(
      borderRadius: .vertical(top: .circular(AppRadius.dialog.value)),
      side: const BorderSide(color: kDarkDelicateGoldBorderColor),
    ),
    clipBehavior: .antiAlias,
  );
}
