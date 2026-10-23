import 'package:equatable/equatable.dart';
import 'package:material_ui/material_ui.dart';

class ThemeModeEntity extends Equatable {
  const new({required this.label, required this.mode});
  final String label;
  final ThemeMode mode;
  @override
  List<Object?> get props => [label, mode];
}
