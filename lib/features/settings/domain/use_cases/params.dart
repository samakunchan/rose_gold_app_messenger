import 'package:equatable/equatable.dart';
import 'package:material_ui/material_ui.dart';

class ThemeModeParams extends Equatable {
  const new({required this.selectedThemeMode});

  final ThemeMode selectedThemeMode;

  @override
  List<Object?> get props => <Object?>[selectedThemeMode];
}

class LanguageParams extends Equatable {
  const new({required this.languageCode});

  final String languageCode;

  @override
  List<Object?> get props => <Object?>[languageCode];
}
