import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/entities/language_entity.dart';

part 'language_model.freezed.dart';
part 'language_model.g.dart';

@freezed
abstract class LanguageModel with _$LanguageModel {
  factory({
    required String label,
    required String languageCode,
  }) = _LanguageModel;

  factory fromJson(Map<String, dynamic> json) => _$LanguageModelFromJson(json);
}

extension LanguageModelX on LanguageModel {
  LanguageEntity toEntity() => LanguageEntity(
    label: label,
    languageCode: languageCode,
  );
}
