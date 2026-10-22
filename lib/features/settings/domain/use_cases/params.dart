import 'package:equatable/equatable.dart';
import 'package:material_ui/material_ui.dart';

class ThemeModeParams extends Equatable {
  const new({required this.selectedThemeMode});

  final ThemeMode selectedThemeMode;

  @override
  List<Object?> get props => <Object?>[selectedThemeMode];
}
