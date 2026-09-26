import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_statics_export.dart';

final BorderRadius _kCapsuleInputBorderRadius = .circular(AppRadius.full.value);
const EdgeInsets _kInputContentPadding = .symmetric(
  horizontal: 18,
  vertical: 12,
);

class AppInputDecorationTheme {
  static final InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: kTranslucentIvoryColor,
    contentPadding: _kInputContentPadding,
    hintStyle: TextStyle(color: kTaupeMutedTextColor, fontFamily: kFontFamily, fontSize: AppFontSize.bodyMd.value, fontWeight: .w400),
    labelStyle: TextStyle(color: kTaupeMutedTextColor, fontFamily: kFontFamily, fontSize: AppFontSize.bodyMd.value, fontWeight: .w500),
    prefixIconColor: kChampagneGoldColor,
    suffixIconColor: kChampagneGoldColor,
    enabledBorder: OutlineInputBorder(
      borderRadius: _kCapsuleInputBorderRadius,
      borderSide: const BorderSide(color: kGoldInputBorderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: _kCapsuleInputBorderRadius,
      borderSide: const BorderSide(color: kChampagneGoldColor, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: _kCapsuleInputBorderRadius,
      borderSide: const BorderSide(color: kLightErrorColor, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: _kCapsuleInputBorderRadius,
      borderSide: const BorderSide(color: kLightErrorColor, width: 2),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: _kCapsuleInputBorderRadius,
      borderSide: BorderSide(color: kHairlineDividerColor.withValues(alpha: 0.5)),
    ),
  );

  static final InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: kDarkTranslucentIvoryColor,
    contentPadding: _kInputContentPadding,
    hintStyle: TextStyle(color: kDarkTaupeMutedTextColor, fontFamily: kFontFamily, fontSize: AppFontSize.bodyMd.value, fontWeight: .w400),
    labelStyle: TextStyle(color: kDarkTaupeMutedTextColor, fontFamily: kFontFamily, fontSize: AppFontSize.bodyMd.value, fontWeight: .w500),
    prefixIconColor: kDarkSecondaryColor,
    suffixIconColor: kDarkSecondaryColor,
    enabledBorder: OutlineInputBorder(
      borderRadius: _kCapsuleInputBorderRadius,
      borderSide: const BorderSide(color: kDarkGoldInputBorderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: _kCapsuleInputBorderRadius,
      borderSide: const BorderSide(color: kDarkSecondaryColor, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: _kCapsuleInputBorderRadius,
      borderSide: const BorderSide(color: kDarkErrorColor, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: _kCapsuleInputBorderRadius,
      borderSide: const BorderSide(color: kDarkErrorColor, width: 2),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: _kCapsuleInputBorderRadius,
      borderSide: BorderSide(color: kDarkHairlineDividerColor.withValues(alpha: 0.5)),
    ),
  );
}
