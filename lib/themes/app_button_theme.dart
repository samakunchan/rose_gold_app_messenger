import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_statics_export.dart';

const OutlinedBorder kPillShapeBorder = StadiumBorder();

EdgeInsets _kButtonPadding = .all(AppSpacing.spaceSm.value);
EdgeInsets _kIconButtonPadding = .all(AppSpacing.spaceMd.value);

TextStyle kDefaultTextStyle() => TextStyle(fontFamily: kFontFamily, fontSize: AppFontSize.bodyMd.value, fontWeight: .w600);

final WidgetStateProperty<double?> _elevation = .resolveWith(
  (Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return 0.0;
    }
    if (states.contains(WidgetState.pressed)) {
      return 2.0;
    }
    if (states.contains(WidgetState.hovered)) {
      return 8.0;
    }
    return 6.0;
  },
);

class AppButtonTheme {
  /// Elevated Button Themes
  static final ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(style: _elevatedStylePrimaryLight);

  static final ElevatedButtonThemeData darkElevatedButtonTheme = ElevatedButtonThemeData(style: _elevatedStylePrimaryDark);

  /// Outlined Button Themes
  static final OutlinedButtonThemeData lightOutlinedButtonTheme = OutlinedButtonThemeData(style: _outlinedStyleLight);

  static final OutlinedButtonThemeData darkOutlinedButtonTheme = OutlinedButtonThemeData(style: _outlinedStyleDark);

  /// Text / Ghost Button Theme
  static final TextButtonThemeData textButtonThemeLight = TextButtonThemeData(style: _textButtonStyleLight);

  static final TextButtonThemeData textButtonThemeDark = TextButtonThemeData(style: _textButtonStyleDark);

  /// Icon Button Theme
  static final IconButtonThemeData iconButtonThemeLight = IconButtonThemeData(style: _iconButtonStyleLight);

  static final IconButtonThemeData iconButtonThemeDark = IconButtonThemeData(style: _iconButtonStyleDark);

  /// Filled Button Theme
  static final FilledButtonThemeData filledButtonThemeLight = FilledButtonThemeData(style: _filledButtonStyleLight);

  static final FilledButtonThemeData filledButtonThemeDark = FilledButtonThemeData(style: _filledButtonStyleDark);

  /// Segmented Button Theme
  static final SegmentedButtonThemeData lightSegmentedButtonTheme = SegmentedButtonThemeData(style: _segmentedButtonStyleLight);

  static final SegmentedButtonThemeData darkSegmentedButtonTheme = SegmentedButtonThemeData(style: _segmentedButtonStyleDark);

  // /// Floating Action Button Theme
  // static final FloatingActionButtonThemeData lightFAButtonTheme = FloatingActionButtonThemeData( _segmentedButtonStyleLight);
  //
  // static final FloatingActionButtonThemeData darkFAButtonTheme = FloatingActionButtonThemeData(style: _segmentedButtonStyleDark);

  /// Styles Implementation
  static final ButtonStyle _baseButtonStyle =
      ElevatedButton.styleFrom(
        shape: kPillShapeBorder,
        padding: _kButtonPadding,
        enabledMouseCursor: SystemMouseCursors.click,
        animationDuration: const Duration(milliseconds: 300),
        textStyle: TextStyle(fontFamily: kFontFamily, fontSize: AppFontSize.bodyMd.value, fontWeight: .w600, letterSpacing: 0.28),
      ).copyWith(
        elevation: _elevation,
        surfaceTintColor: const WidgetStatePropertyAll<Color?>(Colors.transparent),
      );

  /// Primary Elevated Button (Deep Blush)
  static final ButtonStyle _elevatedStylePrimaryLight = _baseButtonStyle.copyWith(
    backgroundColor: .resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return kLightSurfaceContainerHighestColor;
      }
      return kLightPrimaryContainerColor;
    }),
    foregroundColor: .resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return kTaupeMutedTextColor;
      }
      return kLightOnPrimaryColor;
    }),
    shadowColor: .resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.transparent;
      }
      return kLightPrimaryColor.withValues(alpha: 0.3);
    }),
    side: const WidgetStatePropertyAll<BorderSide?>(BorderSide(color: Color(0x59FFFFFF))),
  );

  static final ButtonStyle _elevatedStylePrimaryDark = _baseButtonStyle.copyWith(
    backgroundColor: .resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return kDarkSurfaceContainerLowColor;
      }
      return kDarkPrimaryColor;
    }),
    foregroundColor: .resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return kDarkTaupeMutedTextColor;
      }
      return kDarkOnPrimaryColor;
    }),
    shadowColor: .resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.transparent;
      }
      return kDarkPrimaryColor.withValues(alpha: 0.3);
    }),
    side: const WidgetStatePropertyAll<BorderSide?>(BorderSide(color: Color(0x59FFFFFF))),
  );

  /// Outlined Button (Brushed Gold Rim)
  static final ButtonStyle _outlinedStyleLight =
      OutlinedButton.styleFrom(
        shape: kPillShapeBorder,
        padding: _kButtonPadding,
        foregroundColor: kChampagneGoldColor,
        side: const BorderSide(color: kGhostGoldBorderColor),
        textStyle: kDefaultTextStyle(),
      ).copyWith(
        overlayColor: .resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
            return kBlushSoftColor.withValues(alpha: 0.15);
          }
          return null;
        }),
      );

  static final ButtonStyle _outlinedStyleDark =
      OutlinedButton.styleFrom(
        shape: kPillShapeBorder,
        padding: _kButtonPadding,
        foregroundColor: kDarkSecondaryColor,
        side: const BorderSide(color: kDarkDelicateGoldBorderColor),
        textStyle: kDefaultTextStyle(),
      ).copyWith(
        overlayColor: .resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
            return kDarkPrimaryColor.withValues(alpha: 0.15);
          }
          return null;
        }),
      );

  // Text Button (Ghost)
  static final ButtonStyle _textButtonStyleLight =
      TextButton.styleFrom(
        shape: kPillShapeBorder,
        padding: _kButtonPadding,
        foregroundColor: kLightPrimaryColor,
        textStyle: kDefaultTextStyle(),
      ).copyWith(
        overlayColor: .resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
            return kLightPrimaryColor.withValues(alpha: 0.08);
          }
          return null;
        }),
      );

  static final ButtonStyle _textButtonStyleDark =
      TextButton.styleFrom(
        shape: kPillShapeBorder,
        padding: _kButtonPadding,
        foregroundColor: kDarkPrimaryColor,
        textStyle: kDefaultTextStyle(),
      ).copyWith(
        overlayColor: .resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
            return kDarkPrimaryColor.withValues(alpha: 0.08);
          }
          return null;
        }),
      );

  // Icon Button
  static final ButtonStyle _iconButtonStyleLight = IconButton.styleFrom(
    shape: kPillShapeBorder,
    padding: _kIconButtonPadding,
    foregroundColor: kLightPrimaryColor,
    hoverColor: kLightPrimaryColor.withValues(alpha: 0.08),
    highlightColor: kLightPrimaryColor.withValues(alpha: 0.12),
  );

  static final ButtonStyle _iconButtonStyleDark = IconButton.styleFrom(
    shape: kPillShapeBorder,
    padding: _kIconButtonPadding,
    foregroundColor: kDarkPrimaryColor,
    hoverColor: kDarkPrimaryColor.withValues(alpha: 0.08),
    highlightColor: kDarkPrimaryColor.withValues(alpha: 0.12),
  );

  // Filled Button
  static final ButtonStyle _filledButtonStyleLight = FilledButton.styleFrom(
    shape: kPillShapeBorder,
    padding: _kButtonPadding,
    backgroundColor: kLightPrimaryColor,
    foregroundColor: kLightOnPrimaryColor,
  );

  static final ButtonStyle _filledButtonStyleDark = FilledButton.styleFrom(
    shape: kPillShapeBorder,
    padding: _kButtonPadding,
    backgroundColor: kDarkPrimaryColor,
    foregroundColor: kDarkOnPrimaryColor,
  );

  // Segmented Button
  static final ButtonStyle _segmentedButtonStyleLight = ButtonStyle(
    shape: const WidgetStatePropertyAll<OutlinedBorder>(kPillShapeBorder),
    padding: WidgetStatePropertyAll<EdgeInsets>(_kIconButtonPadding),
    backgroundColor: .resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return kBlushTintLightColor;
      }
      return Colors.transparent;
    }),
    foregroundColor: .resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return kEspressoTextColor;
      }
      return kTaupeMutedTextColor;
    }),
    side: .resolveWith<BorderSide?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const BorderSide(color: kChampagneGoldColor);
      }
      return const BorderSide(color: kHairlineDividerColor);
    }),
  );

  static final ButtonStyle _segmentedButtonStyleDark = ButtonStyle(
    shape: const WidgetStatePropertyAll<OutlinedBorder>(kPillShapeBorder),
    padding: WidgetStatePropertyAll<EdgeInsets>(_kIconButtonPadding),
    backgroundColor: .resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return kDarkPrimaryContainerColor;
      }
      return Colors.transparent;
    }),
    foregroundColor: .resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return kDarkOnSurfaceColor;
      }
      return kDarkTaupeMutedTextColor;
    }),
    side: .resolveWith<BorderSide?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const BorderSide(color: kDarkSecondaryColor);
      }
      return const BorderSide(color: kDarkHairlineDividerColor);
    }),
  );
}
