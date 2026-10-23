import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/entities/theme_mode_entity.dart';

part 'theme_mode_model.freezed.dart';
part 'theme_mode_model.g.dart';

@freezed
abstract class ThemeModeModel with _$ThemeModeModel {
  factory({
    required String label,
    required ThemeMode mode,
  }) = _ThemeModeModel;

  factory fromJson(Map<String, dynamic> json) => _$ThemeModeModelFromJson(json);
}

extension ThemeModeModelX on ThemeModeModel {
  ThemeModeEntity toEntity() => ThemeModeEntity(
    label: label,
    mode: mode,
  );
}
