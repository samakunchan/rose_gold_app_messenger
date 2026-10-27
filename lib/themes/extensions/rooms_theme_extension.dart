import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/themes/themes_statics_export.dart';

class RoomsThemeExtension extends ThemeExtension<RoomsThemeExtension> {
  const new({
    required this.primaryColor,
    required this.primaryTextColor,
    required this.primaryBorderColor,
    required this.secondaryColor,
    required this.secondaryTextColor,
    required this.secondaryBorderColor,
    required this.tertiaryColor,
    required this.satinFrostOverlayColor,
    required this.incomingBorderColor,
    required this.onlineRingColor,
    required this.screenBackgroundGradient,
    required this.medaillonBackgroundGradient,
  });

  final Color primaryColor;
  final Color primaryTextColor;
  final Color primaryBorderColor;
  final Color secondaryColor;
  final Color secondaryTextColor;
  final Color secondaryBorderColor;
  final Color tertiaryColor;
  final Color satinFrostOverlayColor;
  final Color incomingBorderColor;
  final Color onlineRingColor;
  final LinearGradient screenBackgroundGradient;
  final LinearGradient medaillonBackgroundGradient;

  ButtonStyle get primaryOutlinedDecorationButton => OutlinedButton.styleFrom(
    padding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceXs.value),
    side: BorderSide(color: onlineRingColor.withValues(alpha: 0.4)),
  );

  /// Bouton rose
  ButtonStyle get primaryDecorationButton =>
      ElevatedButton.styleFrom(padding: .all(AppSpacing.spaceMd.value), enabledMouseCursor: SystemMouseCursors.click).copyWith(
        elevation: .resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return 0;
          }
          if (states.contains(WidgetState.pressed)) {
            return 2;
          }
          if (states.contains(WidgetState.hovered)) {
            return 8;
          }
          return 6;
        }),

        foregroundColor: WidgetStatePropertyAll<Color>(primaryTextColor),
        backgroundColor: WidgetStatePropertyAll<Color>(primaryColor),
        side: WidgetStatePropertyAll<BorderSide>(BorderSide(color: primaryBorderColor)),
      );

  /// Bouton jaune
  ButtonStyle get secondaryDecorationButton =>
      ElevatedButton.styleFrom(
        padding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: 0),
        enabledMouseCursor: SystemMouseCursors.click,
      ).copyWith(
        elevation: .resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return 0;
          }
          if (states.contains(WidgetState.pressed)) {
            return 2;
          }
          if (states.contains(WidgetState.hovered)) {
            return 8;
          }
          return 6;
        }),

        foregroundColor: WidgetStatePropertyAll<Color>(secondaryTextColor),
        backgroundColor: WidgetStatePropertyAll<Color>(secondaryColor),
        side: WidgetStatePropertyAll<BorderSide>(BorderSide(width: 0.5, color: secondaryBorderColor)),
      );

  BoxDecoration get primaryCardDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: .all(.circular(AppRadius.full.value)),
    boxShadow: <BoxShadow>[
      BoxShadow(color: Colors.black.withValues(alpha: 0.18), offset: const Offset(0, 1)),
    ],
  );

  BoxDecoration get secondaryCardDecoration => BoxDecoration(
    gradient: screenBackgroundGradient,
    borderRadius: .all(.circular(AppRadius.full.value)),
    border: Border(
      left: BorderSide(color: tertiaryColor, width: 2),
      right: BorderSide(color: tertiaryColor, width: 2),
      top: BorderSide(color: tertiaryColor, width: 2),
      bottom: BorderSide(color: tertiaryColor, width: 2),
    ),
  );

  BoxDecoration get invitationCardDecoration => BoxDecoration(
    color: satinFrostOverlayColor,
    borderRadius: .all(.circular(AppRadius.lg.value)),
    border: .all(color: incomingBorderColor, width: 0.8),
    boxShadow: <BoxShadow>[
      BoxShadow(color: onlineRingColor.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, 4)),
    ],
  );

  /// Badge rose
  BoxDecoration get badgePrimaryDecoration => BoxDecoration(
    borderRadius: .all(.circular(AppRadius.defaultValue.value)),
    border: .all(color: onlineRingColor.withValues(alpha: 0.35), width: 0.8),
    gradient: medaillonBackgroundGradient,
  );

  /// Badge jaune
  BoxDecoration get badgeSecondaryDecoration => BoxDecoration(
    color: secondaryColor,
    borderRadius: .all(.circular(AppRadius.defaultValue.value)),
    border: .all(color: onlineRingColor.withValues(alpha: 0.35), width: 0.8),
  );

  /// Avatar bg rose
  BoxDecoration get avatarContainerDecoration => BoxDecoration(
    shape: .circle,
    color: primaryColor,
    border: .all(color: secondaryBorderColor, width: 1.5),
    gradient: medaillonBackgroundGradient,
  );

  /// Card avec un gradient rose léger
  BoxDecoration get userInfoCardDecoration => BoxDecoration(
    color: satinFrostOverlayColor,
    borderRadius: .all(.circular(AppRadius.lg.value)),
    border: .all(color: incomingBorderColor, width: 0.8),
    gradient: screenBackgroundGradient,
    boxShadow: <BoxShadow>[
      BoxShadow(color: onlineRingColor.withValues(alpha: 0.08), blurRadius: 24, offset: const Offset(0, 8)),
      BoxShadow(color: const Color(0xff000000).withValues(alpha: 0.03), blurRadius: 6, offset: const Offset(0, 2)),
    ],
  );

  static const RoomsThemeExtension light = RoomsThemeExtension(
    primaryColor: kLightPrimaryColor,
    primaryTextColor: kLightOnSecondaryColor,
    primaryBorderColor: kLightSecondaryContainerColor,
    secondaryColor: kLightSecondaryContainerColor,
    secondaryTextColor: kLightOnSecondaryContainerColor,
    secondaryBorderColor: kChampagneGoldColor,
    tertiaryColor: kLightTertiaryFixedColor,
    satinFrostOverlayColor: kSatinFrostSurfaceColor,
    incomingBorderColor: Color(0x33D4AF37),
    onlineRingColor: kChampagneGoldBrightColor,
    screenBackgroundGradient: kLightScreenBackgroundGradient,
    medaillonBackgroundGradient: LinearGradient(
      begin: .topLeft,
      end: .bottomRight,
      colors: <Color>[
        kLightPrimaryContainerColor,
        kLightPrimaryContainerColor,
        kLightPrimaryColor,
      ],
    ),
  );

  static const RoomsThemeExtension dark = RoomsThemeExtension(
    primaryColor: kDarkPrimaryColor,
    primaryTextColor: kLightSurfaceColor,
    primaryBorderColor: kLightSecondaryContainerColor,
    secondaryColor: kDarkPrimaryColor,
    secondaryTextColor: kLightOnSecondaryColor,
    secondaryBorderColor: kDarkSecondaryColor,
    tertiaryColor: kDarkTertiaryContainerColor,
    satinFrostOverlayColor: kDarkSatinFrostSurfaceColor,
    incomingBorderColor: kDarkDelicateGoldBorderColor,
    onlineRingColor: kDarkSecondaryColor,
    screenBackgroundGradient: kDarkScreenBackgroundGradient,
    medaillonBackgroundGradient: LinearGradient(
      begin: .topLeft,
      end: .bottomRight,
      colors: <Color>[
        kLightPrimaryColor,
        kChampagneGoldBrightColor,
        kChampagneGoldBrightColor,
        kLightSecondaryColor,
      ],
      stops: <double>[0, .35, 0.55, 1],
    ),
  );

  @override
  RoomsThemeExtension copyWith({
    Color? primaryColor,
    Color? primaryTextColor,
    Color? primaryBorderColor,
    Color? secondaryColor,
    Color? secondaryTextColor,
    Color? secondaryBorderColor,
    Color? tertiaryColor,
    Color? satinFrostOverlayColor,
    Color? incomingBorderColor,
    Color? onlineRingColor,
    LinearGradient? screenBackgroundGradient,
    LinearGradient? medaillonBackgroundGradient,
  }) {
    return RoomsThemeExtension(
      primaryColor: primaryColor ?? this.primaryColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      primaryBorderColor: primaryBorderColor ?? this.primaryBorderColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      secondaryBorderColor: secondaryBorderColor ?? this.secondaryBorderColor,
      tertiaryColor: tertiaryColor ?? this.tertiaryColor,
      screenBackgroundGradient: screenBackgroundGradient ?? this.screenBackgroundGradient,
      medaillonBackgroundGradient: medaillonBackgroundGradient ?? this.medaillonBackgroundGradient,
      satinFrostOverlayColor: satinFrostOverlayColor ?? this.satinFrostOverlayColor,
      incomingBorderColor: incomingBorderColor ?? this.incomingBorderColor,
      onlineRingColor: onlineRingColor ?? this.onlineRingColor,
    );
  }

  @override
  RoomsThemeExtension lerp(ThemeExtension<RoomsThemeExtension>? other, double t) {
    if (other is! RoomsThemeExtension) {
      return this;
    }
    return RoomsThemeExtension(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      primaryTextColor: Color.lerp(primaryTextColor, other.primaryTextColor, t)!,
      primaryBorderColor: Color.lerp(primaryBorderColor, other.primaryBorderColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      secondaryTextColor: Color.lerp(secondaryTextColor, other.secondaryTextColor, t)!,
      secondaryBorderColor: Color.lerp(secondaryBorderColor, other.secondaryBorderColor, t)!,
      tertiaryColor: Color.lerp(tertiaryColor, other.tertiaryColor, t)!,
      satinFrostOverlayColor: Color.lerp(satinFrostOverlayColor, other.satinFrostOverlayColor, t)!,
      incomingBorderColor: Color.lerp(incomingBorderColor, other.incomingBorderColor, t)!,
      onlineRingColor: Color.lerp(onlineRingColor, other.onlineRingColor, t)!,
      screenBackgroundGradient: LinearGradient.lerp(screenBackgroundGradient, other.screenBackgroundGradient, t)!,
      medaillonBackgroundGradient: LinearGradient.lerp(medaillonBackgroundGradient, other.medaillonBackgroundGradient, t)!,
    );
  }
}
