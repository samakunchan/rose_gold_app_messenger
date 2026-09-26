// ============================================================================
// RADIUS SYSTEM (High Roundedness & Pill Contours)
// ============================================================================

import 'package:flutter/material.dart';

enum AppRadius {
  /// Size: 3.0 (speech bubble tail notch)
  bubbleTail(value: 3),

  /// Size: 4.0 (xs)
  xs(value: 4),

  /// Size: 6.0 (badge)
  badge(value: 6),

  /// Size: 8.0 (sm)
  sm(value: 8),

  /// Size: 12.0 (card / option item)
  card(value: 12),

  /// Size: 16.0 (DEFAULT)
  defaultValue(value: 16),

  /// Size: 20.0 (bubble)
  bubble(value: 20),

  /// Size: 24.0 (md)
  md(value: 24),

  /// Size: 28.0 (dialog / bottom sheet)
  dialog(value: 28),

  /// Size: 32.0 (lg)
  lg(value: 32),

  /// Size: 48.0 (xl)
  xl(value: 48),

  /// Size: 9999.0 (full pill)
  full(value: 9999);

  new({required this.value});
  final double value;

  Radius get asRadius => Radius.circular(value);
  BorderRadius get asBorderRadius => BorderRadius.circular(value);
}
