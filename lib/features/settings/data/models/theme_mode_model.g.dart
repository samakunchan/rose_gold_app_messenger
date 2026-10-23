// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ThemeModeModel _$ThemeModeModelFromJson(Map<String, dynamic> json) =>
    _ThemeModeModel(
      label: json['label'] as String,
      mode: $enumDecode(_$ThemeModeEnumMap, json['mode']),
    );

Map<String, dynamic> _$ThemeModeModelToJson(_ThemeModeModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'mode': _$ThemeModeEnumMap[instance.mode]!,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
