import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:rose_gold_app_messenger/themes/themes_statics_export.dart';

class FrontThemeExtension extends ThemeExtension<FrontThemeExtension> {
  const new({
    required this.elevatedButtonGradient,
    required this.elevatedButtonPressedGradient,
    required this.disabledElevatedButtonGradient,
    required this.screenBackgroundGradient,
    required this.satinFrostOverlayColor,
    required this.conversationDividerColor,
    required this.incomingBorderColor,
    required this.onlineRingColor,
    required this.border,
    required this.medallionGradient,
    required this.medallionInnerGradient,
    required this.medallionShadows,
    required this.medallionDialColor,
    required this.medallionInnerBorder,
  });

  final LinearGradient elevatedButtonGradient;
  final LinearGradient elevatedButtonPressedGradient;
  final LinearGradient disabledElevatedButtonGradient;
  final LinearGradient screenBackgroundGradient;
  final Color satinFrostOverlayColor;
  final Color conversationDividerColor;
  final Color incomingBorderColor;
  final Color onlineRingColor;
  final BoxBorder border;
  final LinearGradient medallionGradient;
  final LinearGradient medallionInnerGradient;
  final List<BoxShadow> medallionShadows;
  final Color medallionDialColor;
  final Border medallionInnerBorder;

  /// Elevated button style with smooth animated linear gradient for front screens (Splash, Auth).
  ButtonStyle get elevatedButtonStyle {
    return ElevatedButton.styleFrom(
      shape: const StadiumBorder(),
      padding: const .symmetric(horizontal: 24, vertical: 16),
      enabledMouseCursor: SystemMouseCursors.click,
      animationDuration: const Duration(milliseconds: 300),
      textStyle: TextStyle(fontFamily: kFontFamily, fontSize: AppFontSize.bodyMd.value, fontWeight: .w600, letterSpacing: 0.28),
    ).copyWith(
      elevation: .resolveWith((Set<WidgetState> states) {
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
      }),
      surfaceTintColor: const WidgetStatePropertyAll<Color?>(Colors.transparent),
      backgroundColor: const WidgetStatePropertyAll<Color?>(Colors.transparent),
      foregroundColor: .resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return kTaupeMutedTextColor;
        }
        return Colors.white;
      }),
      shadowColor: .resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.transparent;
        }
        return elevatedButtonGradient.colors.first.withValues(alpha: 0.30);
      }),
      backgroundBuilder: (BuildContext context, Set<WidgetState> states, Widget? child) {
        final LinearGradient gradient;
        if (states.contains(WidgetState.disabled)) {
          gradient = disabledElevatedButtonGradient;
        } else if (states.contains(WidgetState.pressed)) {
          gradient = elevatedButtonPressedGradient;
        } else {
          gradient = elevatedButtonGradient;
        }

        return TweenAnimationBuilder<Decoration>(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          tween: DecorationTween(
            end: ShapeDecoration(gradient: gradient, shape: const StadiumBorder()),
          ),
          builder: (BuildContext context, Decoration decoration, Widget? child) {
            return Ink(
              decoration: decoration,
              child: child,
            );
          },
          child: child,
        );
      },
    );
  }

  static final FrontThemeExtension light = FrontThemeExtension(
    elevatedButtonGradient: kLightElevatedButtonGradient,
    elevatedButtonPressedGradient: kLightElevatedButtonPressedGradient,
    disabledElevatedButtonGradient: kDisabledElevatedButtonGradient,
    screenBackgroundGradient: kLightScreenBackgroundGradient,
    satinFrostOverlayColor: kSatinFrostSurfaceColor,
    conversationDividerColor: kHairlineDividerColor,
    incomingBorderColor: const Color(0x33D4AF37),
    onlineRingColor: kChampagneGoldBrightColor,
    border: const GradientBoxBorder(
      gradient: LinearGradient(
        begin: .topLeft,
        end: .bottomRight,
        colors: <Color>[
          kChampagneGoldDeepColor,
          kDarkSecondaryColor,
          Color(0xFFFBEAE7),
          kChampagneGoldBrightColor,
          kChampagneGoldDeepColor,
        ],
      ),
      width: 2.5,
    ),
    medallionGradient: const LinearGradient(
      begin: .topLeft,
      end: .bottomRight,
      colors: <Color>[
        kLightPrimaryColor,
        kChampagneGoldBrightColor,
        kLightSecondaryColor,
      ],
      stops: <double>[0, 0.55, 1],
    ),
    medallionInnerGradient: const LinearGradient(
      begin: .topLeft,
      end: .bottomRight,
      colors: <Color>[
        Color(0xFFFBEAE7),
        Color(0xFFF5D6D0),
        Color(0xFFF2D1CA),
      ],
    ),
    medallionShadows: <BoxShadow>[
      BoxShadow(
        color: kLightPrimaryContainerColor.withValues(alpha: 0.38),
        blurRadius: 36,
        spreadRadius: 4,
        offset: const Offset(0, 10),
      ),
      BoxShadow(color: kChampagneGoldColor.withValues(alpha: 0.26), blurRadius: 20, spreadRadius: 2, offset: const Offset(0, 4)),
      BoxShadow(color: kEspressoTextColor.withValues(alpha: 0.14), blurRadius: 20, offset: const Offset(0, 12)),
      BoxShadow(color: kEspressoDarkTextColor.withValues(alpha: 0.12), blurRadius: 6, offset: const Offset(0, 3)),
    ],
    medallionDialColor: Colors.white,
    medallionInnerBorder: .all(color: kChampagneGoldBrightColor.withValues(alpha: 0.45), width: 1.2),
  );

  static final FrontThemeExtension dark = FrontThemeExtension(
    elevatedButtonGradient: kDarkElevatedButtonGradient,
    elevatedButtonPressedGradient: kDarkElevatedButtonPressedGradient,
    disabledElevatedButtonGradient: kDarkDisabledElevatedButtonGradient,
    screenBackgroundGradient: kDarkScreenBackgroundGradient,
    satinFrostOverlayColor: kDarkSatinFrostSurfaceColor,
    conversationDividerColor: kDarkHairlineDividerColor,
    incomingBorderColor: kDarkDelicateGoldBorderColor,
    onlineRingColor: kDarkSecondaryColor,
    border: const GradientBoxBorder(
      gradient: LinearGradient(
        begin: Alignment(-0.8, -0.8),
        end: Alignment(0.8, 0.8),
        colors: <Color>[
          kDarkSecondaryColor,
          Color(0xFFFFF7E2),
          Colors.white,
          kDarkPrimaryColor,
          Color(0xFFFFE6AB),
          kDarkSecondaryContainerColor,
        ],
        stops: <double>[0, 0.20, 0.40, 0.62, 0.80, 1],
      ),
      width: 2.5,
    ),
    medallionGradient: const LinearGradient(
      begin: .topLeft,
      end: .bottomRight,
      colors: <Color>[
        Color(0xFFFFE5A3),
        Colors.white,
        kDarkPrimaryColor,
        kDarkSecondaryColor,
      ],
      stops: <double>[0, 0.35, 0.70, 1],
    ),
    medallionInnerGradient: LinearGradient(
      begin: .topLeft,
      end: .bottomRight,
      colors: <Color>[
        kDarkPrimaryContainerColor.withValues(alpha: 0.35),
        const Color(0xFF141217),
        kDarkSecondaryContainerColor.withValues(alpha: 0.25),
      ],
    ),
    medallionShadows: <BoxShadow>[
      BoxShadow(color: kDarkSecondaryColor.withValues(alpha: 0.32), blurRadius: 56, spreadRadius: 8, offset: const Offset(0, 6)),
      BoxShadow(color: kDarkPrimaryColor.withValues(alpha: 0.20), blurRadius: 32, spreadRadius: 2, offset: const Offset(0, 2)),
      BoxShadow(color: Colors.black.withValues(alpha: 0.65), blurRadius: 30, offset: const Offset(0, 16)),
      BoxShadow(color: Colors.black.withValues(alpha: 0.50), blurRadius: 10, offset: const Offset(0, 4), spreadRadius: -1),
    ],
    medallionDialColor: const Color(0xFF1B181E),
    medallionInnerBorder: .all(color: kDarkSecondaryColor.withValues(alpha: 0.30), width: 1.2),
  );

  @override
  FrontThemeExtension copyWith({
    LinearGradient? elevatedButtonGradient,
    LinearGradient? elevatedButtonPressedGradient,
    LinearGradient? disabledElevatedButtonGradient,
    LinearGradient? screenBackgroundGradient,
    Color? satinFrostOverlayColor,
    Color? conversationDividerColor,
    Color? incomingBorderColor,
    Color? onlineRingColor,
    BoxBorder? border,
    LinearGradient? medallionGradient,
    LinearGradient? medallionInnerGradient,
    List<BoxShadow>? medallionShadows,
    Color? medallionDialColor,
    Border? medallionInnerBorder,
  }) {
    return FrontThemeExtension(
      elevatedButtonGradient: elevatedButtonGradient ?? this.elevatedButtonGradient,
      elevatedButtonPressedGradient: elevatedButtonPressedGradient ?? this.elevatedButtonPressedGradient,
      disabledElevatedButtonGradient: disabledElevatedButtonGradient ?? this.disabledElevatedButtonGradient,
      screenBackgroundGradient: screenBackgroundGradient ?? this.screenBackgroundGradient,
      satinFrostOverlayColor: satinFrostOverlayColor ?? this.satinFrostOverlayColor,
      conversationDividerColor: conversationDividerColor ?? this.conversationDividerColor,
      incomingBorderColor: incomingBorderColor ?? this.incomingBorderColor,
      onlineRingColor: onlineRingColor ?? this.onlineRingColor,
      border: border ?? this.border,
      medallionGradient: medallionGradient ?? this.medallionGradient,
      medallionInnerGradient: medallionInnerGradient ?? this.medallionInnerGradient,
      medallionShadows: medallionShadows ?? this.medallionShadows,
      medallionDialColor: medallionDialColor ?? this.medallionDialColor,
      medallionInnerBorder: medallionInnerBorder ?? this.medallionInnerBorder,
    );
  }

  @override
  FrontThemeExtension lerp(ThemeExtension<FrontThemeExtension>? other, double t) {
    if (other is! FrontThemeExtension) {
      return this;
    }
    return FrontThemeExtension(
      elevatedButtonGradient: LinearGradient.lerp(elevatedButtonGradient, other.elevatedButtonGradient, t)!,
      elevatedButtonPressedGradient: LinearGradient.lerp(elevatedButtonPressedGradient, other.elevatedButtonPressedGradient, t)!,
      disabledElevatedButtonGradient: LinearGradient.lerp(
        disabledElevatedButtonGradient,
        other.disabledElevatedButtonGradient,
        t,
      )!,
      screenBackgroundGradient: LinearGradient.lerp(screenBackgroundGradient, other.screenBackgroundGradient, t)!,
      satinFrostOverlayColor: Color.lerp(satinFrostOverlayColor, other.satinFrostOverlayColor, t)!,
      conversationDividerColor: Color.lerp(conversationDividerColor, other.conversationDividerColor, t)!,
      incomingBorderColor: Color.lerp(incomingBorderColor, other.incomingBorderColor, t)!,
      onlineRingColor: Color.lerp(onlineRingColor, other.onlineRingColor, t)!,
      border: _lerpBorder(border, other.border, t),
      medallionGradient: LinearGradient.lerp(medallionGradient, other.medallionGradient, t)!,
      medallionInnerGradient: LinearGradient.lerp(medallionInnerGradient, other.medallionInnerGradient, t)!,
      medallionShadows: BoxShadow.lerpList(medallionShadows, other.medallionShadows, t) ?? (t < 0.5 ? medallionShadows : other.medallionShadows),
      medallionDialColor: Color.lerp(medallionDialColor, other.medallionDialColor, t)!,
      medallionInnerBorder: Border.lerp(medallionInnerBorder, other.medallionInnerBorder, t)!,
    );
  }

  static BoxBorder _lerpBorder(BoxBorder a, BoxBorder b, double t) {
    if (identical(a, b)) {
      return a;
    }
    if (a is GradientBoxBorder && b is GradientBoxBorder) {
      final Gradient? lerpedGradient = Gradient.lerp(a.gradient, b.gradient, t);
      final double? lerpedWidth = ui.lerpDouble(a.width, b.width, t);
      final double? lerpedStrokeAlign = ui.lerpDouble(a.strokeAlign, b.strokeAlign, t);
      return GradientBoxBorder(
        gradient: lerpedGradient ?? (t < 0.5 ? a.gradient : b.gradient),
        width: lerpedWidth ?? (t < 0.5 ? a.width : b.width),
        strokeAlign: lerpedStrokeAlign ?? (t < 0.5 ? a.strokeAlign : b.strokeAlign),
      );
    }
    if (a is Border && b is Border) {
      return Border.lerp(a, b, t) ?? (t < 0.5 ? a : b);
    }
    if (a is BorderDirectional && b is BorderDirectional) {
      return BorderDirectional.lerp(a, b, t) ?? (t < 0.5 ? a : b);
    }
    return t < 0.5 ? a : b;
  }
}
