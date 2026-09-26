// ============================================================================
// SPACING SYSTEM (Incremental 4px / 8px Rhythm)
// ============================================================================

enum AppSpacing {
  /// Size: 2.0 (space-2xs)
  space2xs(value: 2),

  /// Size: 4.0 (space-xs)
  spaceXs(value: 4),

  /// Size: 8.0 (space-sm)
  spaceSm(value: 8),

  /// Size: 12.0 (space-md)
  spaceMd(value: 12),

  /// Size: 16.0 (space-base)
  spaceBase(value: 16),

  /// Size: 20.0 (space-lg)
  spaceLg(value: 20),

  /// Size: 24.0 (space-xl)
  spaceXl(value: 24),

  /// Size: 32.0 (space-2xl)
  space2xl(value: 32),

  /// Size: 40.0 (space-3xl)
  space3xl(value: 40),

  /// Size: 56.0 (space-4xl)
  space4xl(value: 56);

  new({required this.value});
  final double value;
}
