import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_statics_export.dart';

class ChatThemeExtension extends ThemeExtension<ChatThemeExtension> {
  const new({
    required this.outgoingBubbleGradient,
    required this.outgoingTextColor,
    required this.outgoingBorderColor,
    required this.incomingBubbleColor,
    required this.incomingTextColor,
    required this.incomingBorderColor,
    required this.waveformTrackColor,
    required this.waveformBackgroundColor,
    required this.scrubHandleColor,
    required this.unreadBadgeColor,
    required this.unreadBadgeTextColor,
    required this.onlineRingColor,
    required this.screenBackgroundGradient,
    this.customOutgoingBorderRadius,
    this.customIncomingBorderRadius,
    this.outgoingShadows,
    this.incomingShadows,
    this.incomingBorder,
    this.outgoingBorder,
  });

  final LinearGradient outgoingBubbleGradient;
  final Color outgoingTextColor;
  final Color outgoingBorderColor;

  final Color incomingBubbleColor;
  final Color incomingTextColor;
  final Color incomingBorderColor;

  final Color waveformTrackColor;
  final Color waveformBackgroundColor;
  final Color scrubHandleColor;

  final Color unreadBadgeColor;
  final Color unreadBadgeTextColor;
  final Color onlineRingColor;
  final LinearGradient screenBackgroundGradient;

  final BorderRadius? customOutgoingBorderRadius;
  final BorderRadius? customIncomingBorderRadius;
  final List<BoxShadow>? outgoingShadows;
  final List<BoxShadow>? incomingShadows;
  final BoxBorder? incomingBorder;
  final BoxBorder? outgoingBorder;

  /// Corner radii for outgoing message bubble (anchor corner bottom-right: 6px).
  BorderRadius get outgoingBorderRadius =>
      customOutgoingBorderRadius ??
      .only(
        topLeft: .circular(AppRadius.bubble.value),
        topRight: .circular(AppRadius.bubble.value),
        bottomLeft: .circular(AppRadius.bubble.value),
        bottomRight: .circular(AppRadius.bubbleTail.value),
      );

  /// Corner radii for incoming message bubble (anchor corner bottom-left: 6px).
  BorderRadius get incomingBorderRadius =>
      customIncomingBorderRadius ??
      .only(
        topLeft: .circular(AppRadius.bubble.value),
        topRight: .circular(AppRadius.bubble.value),
        bottomLeft: .circular(AppRadius.bubbleTail.value),
        bottomRight: .circular(AppRadius.bubble.value),
      );

  /// Decoration for outgoing message bubbles.
  BoxDecoration get outgoingBubbleDecoration => BoxDecoration(
    gradient: outgoingBubbleGradient,
    borderRadius: outgoingBorderRadius,
    border: outgoingBorder ?? .all(color: outgoingBorderColor, width: 0.5),
    boxShadow:
        outgoingShadows ??
        <BoxShadow>[
          BoxShadow(color: kLightPrimaryColor.withValues(alpha: 0.12), blurRadius: 8, offset: const Offset(0, 3)),
        ],
  );

  /// Decoration for incoming message bubbles.
  BoxDecoration get incomingBubbleDecoration => BoxDecoration(
    color: incomingBubbleColor,
    borderRadius: incomingBorderRadius,
    border: incomingBorder ?? .all(color: incomingBorderColor, width: 0.5),
    boxShadow:
        incomingShadows ??
        <BoxShadow>[
          BoxShadow(color: kEspressoDarkTextColor.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 3)),
        ],
  );

  /// Decoration for voice note player frosted capsules.
  BoxDecoration get voicePlayerDecoration => BoxDecoration(
    color: waveformBackgroundColor,
    borderRadius: .all(.circular(AppRadius.full.value)),
    border: Border.all(color: incomingBorderColor, width: 0.5),
  );

  /// Decoration for unread badge pills.
  BoxDecoration get unreadBadgeDecoration => BoxDecoration(
    color: unreadBadgeColor,
    borderRadius: .all(.circular(AppRadius.full.value)),
  );

  ButtonStyle get sendMessageElevatedButtonStyle {
    return ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      padding: .all(AppSpacing.spaceLg.value),
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
      shadowColor: .resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.transparent;
        }
        return outgoingBubbleGradient.colors.first.withValues(alpha: 0.5);
      }),
      backgroundBuilder: (BuildContext context, Set<WidgetState> states, Widget? child) {
        final LinearGradient gradient;
        if (states.contains(WidgetState.disabled)) {
          gradient = kDisabledElevatedButtonGradient;
        } else if (states.contains(WidgetState.pressed)) {
          gradient = kDarkElevatedButtonGradient;
        } else {
          gradient = kLightSubmitButtonGradient;
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

  static const ChatThemeExtension light = ChatThemeExtension(
    outgoingBubbleGradient: kLightBubbleGradient,
    outgoingTextColor: kLightOnPrimaryColor,
    outgoingBorderColor: Color(0x66FFFFFF),
    incomingBubbleColor: kLightSurfaceContainerLowestColor,
    incomingTextColor: kEspressoTextColor,
    incomingBorderColor: Color(0x33D4AF37),
    waveformTrackColor: kChampagneGoldLightColor,
    waveformBackgroundColor: Color(0x1AD88B98),
    scrubHandleColor: kChampagneGoldColor,
    unreadBadgeColor: kLightSecondaryContainerColor,
    unreadBadgeTextColor: kLightOnSecondaryContainerColor,
    onlineRingColor: kChampagneGoldColor,
    screenBackgroundGradient: kLightScreenBackgroundGradient,
  );

  static const ChatThemeExtension dark = ChatThemeExtension(
    outgoingBubbleGradient: kDarkBubbleGradient,
    outgoingTextColor: kDarkOnPrimaryColor,
    outgoingBorderColor: Color(0x40FFFFFF),
    incomingBubbleColor: kDarkSurfaceContainerColor,
    incomingTextColor: kDarkOnSurfaceColor,
    incomingBorderColor: kDarkDelicateGoldBorderColor,
    waveformTrackColor: kDarkSecondaryColor,
    waveformBackgroundColor: Color(0x26FFB2BE),
    scrubHandleColor: kDarkSecondaryColor,
    unreadBadgeColor: kDarkSecondaryContainerColor,
    unreadBadgeTextColor: kDarkOnSecondaryContainerColor,
    onlineRingColor: kDarkSecondaryColor,
    screenBackgroundGradient: kDarkScreenBackgroundGradient,
  );

  @override
  ChatThemeExtension copyWith({
    LinearGradient? outgoingBubbleGradient,
    Color? outgoingTextColor,
    Color? outgoingBorderColor,
    Color? incomingBubbleColor,
    Color? incomingTextColor,
    Color? incomingBorderColor,
    Color? waveformTrackColor,
    Color? waveformBackgroundColor,
    Color? scrubHandleColor,
    Color? unreadBadgeColor,
    Color? unreadBadgeTextColor,
    Color? onlineRingColor,
    LinearGradient? screenBackgroundGradient,
    BorderRadius? customOutgoingBorderRadius,
    BorderRadius? customIncomingBorderRadius,
    List<BoxShadow>? outgoingShadows,
    List<BoxShadow>? incomingShadows,
    BoxBorder? incomingBorder,
    BoxBorder? outgoingBorder,
  }) {
    return ChatThemeExtension(
      outgoingBubbleGradient: outgoingBubbleGradient ?? this.outgoingBubbleGradient,
      outgoingTextColor: outgoingTextColor ?? this.outgoingTextColor,
      outgoingBorderColor: outgoingBorderColor ?? this.outgoingBorderColor,
      incomingBubbleColor: incomingBubbleColor ?? this.incomingBubbleColor,
      incomingTextColor: incomingTextColor ?? this.incomingTextColor,
      incomingBorderColor: incomingBorderColor ?? this.incomingBorderColor,
      waveformTrackColor: waveformTrackColor ?? this.waveformTrackColor,
      waveformBackgroundColor: waveformBackgroundColor ?? this.waveformBackgroundColor,
      scrubHandleColor: scrubHandleColor ?? this.scrubHandleColor,
      unreadBadgeColor: unreadBadgeColor ?? this.unreadBadgeColor,
      unreadBadgeTextColor: unreadBadgeTextColor ?? this.unreadBadgeTextColor,
      onlineRingColor: onlineRingColor ?? this.onlineRingColor,
      screenBackgroundGradient: screenBackgroundGradient ?? this.screenBackgroundGradient,
      customOutgoingBorderRadius: customOutgoingBorderRadius ?? this.customOutgoingBorderRadius,
      customIncomingBorderRadius: customIncomingBorderRadius ?? this.customIncomingBorderRadius,
      outgoingShadows: outgoingShadows ?? this.outgoingShadows,
      incomingShadows: incomingShadows ?? this.incomingShadows,
      incomingBorder: incomingBorder ?? this.incomingBorder,
      outgoingBorder: outgoingBorder ?? this.outgoingBorder,
    );
  }

  @override
  ChatThemeExtension lerp(ThemeExtension<ChatThemeExtension>? other, double t) {
    if (other is! ChatThemeExtension) {
      return this;
    }
    return ChatThemeExtension(
      outgoingBubbleGradient: LinearGradient.lerp(outgoingBubbleGradient, other.outgoingBubbleGradient, t)!,
      outgoingTextColor: Color.lerp(outgoingTextColor, other.outgoingTextColor, t)!,
      outgoingBorderColor: Color.lerp(outgoingBorderColor, other.outgoingBorderColor, t)!,
      incomingBubbleColor: Color.lerp(incomingBubbleColor, other.incomingBubbleColor, t)!,
      incomingTextColor: Color.lerp(incomingTextColor, other.incomingTextColor, t)!,
      incomingBorderColor: Color.lerp(incomingBorderColor, other.incomingBorderColor, t)!,
      waveformTrackColor: Color.lerp(waveformTrackColor, other.waveformTrackColor, t)!,
      waveformBackgroundColor: Color.lerp(waveformBackgroundColor, other.waveformBackgroundColor, t)!,
      scrubHandleColor: Color.lerp(scrubHandleColor, other.scrubHandleColor, t)!,
      unreadBadgeColor: Color.lerp(unreadBadgeColor, other.unreadBadgeColor, t)!,
      unreadBadgeTextColor: Color.lerp(unreadBadgeTextColor, other.unreadBadgeTextColor, t)!,
      onlineRingColor: Color.lerp(onlineRingColor, other.onlineRingColor, t)!,
      screenBackgroundGradient: LinearGradient.lerp(screenBackgroundGradient, other.screenBackgroundGradient, t)!,
      customOutgoingBorderRadius: BorderRadius.lerp(customOutgoingBorderRadius, other.customOutgoingBorderRadius, t),
      customIncomingBorderRadius: BorderRadius.lerp(customIncomingBorderRadius, other.customIncomingBorderRadius, t),
      outgoingShadows: BoxShadow.lerpList(outgoingShadows, other.outgoingShadows, t) ?? (t < 0.5 ? outgoingShadows : other.outgoingShadows),
      incomingShadows: BoxShadow.lerpList(incomingShadows, other.incomingShadows, t) ?? (t < 0.5 ? incomingShadows : other.incomingShadows),
      incomingBorder: BoxBorder.lerp(incomingBorder, other.incomingBorder, t),
      outgoingBorder: BoxBorder.lerp(outgoingBorder, other.outgoingBorder, t),
    );
  }
}
