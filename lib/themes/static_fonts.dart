/// Primary typography family for the Rose Gold application.
const String kFontFamily = 'Plus Jakarta Sans';

// ============================================================================
// FONT SIZE SYSTEM (Harmonized Typographic Scale)
// ============================================================================

enum AppFontSize {
  /// Size: 10.0 (caption / timestamps / micro tags)
  caption(value: 10),

  /// Size: 11.0 (label-sm / subtitles / navigation text)
  labelSm(value: 11),

  /// Size: 12.0 (label-md / chips / badges)
  labelMd(value: 12),

  /// Size: 13.0 (body-sm / compact reading)
  bodySm(value: 13),

  /// Size: 14.0 (body-md / label-lg / inputs / buttons)
  bodyMd(value: 14),

  /// Size: 16.0 (body-lg / title-medium / list items)
  bodyLg(value: 16),

  /// Size: 18.0 (headline-sm / section headers / app bar)
  headlineSm(value: 18),

  /// Size: 20.0 (headline-md / title-large / dialogs)
  headlineMd(value: 20),

  /// Size: 24.0 (headline-lg / banners)
  headlineLg(value: 24),

  /// Size: 26.0 (display-sm)
  displaySm(value: 26),

  /// Size: 28.0 (display-md / hero mobile)
  displayMd(value: 28),

  /// Size: 36.0 (display-lg / hero display)
  displayLg(value: 36);

  new({required this.value});
  final double value;

  // Semantic aliases
  static const AppFontSize labelLg = bodyMd;
  static const AppFontSize titleSm = bodyMd;
  static const AppFontSize titleMd = bodyLg;
  static const AppFontSize titleLg = headlineMd;
}
