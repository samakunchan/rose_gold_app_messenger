import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/entities/language_entity.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/repositories/languages_repository.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/change_language_use_case.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/params.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/view_models/languages_view_model.dart';
import 'package:signals_flutter/signals_flutter.dart';

class LanguagesSignals {
  new({
    required this.changeLanguageUseCase,
    required this.languagesRepository,
  }) {
    final LanguagesViewModel saved = LanguagesViewModel(languagesRepository.getSavedLanguage());
    code.value = saved.languageCode;
    languageLabel.value = saved.label;
  }

  final ChangeLanguageUseCase changeLanguageUseCase;
  final LanguagesRepository languagesRepository;
  final Signal<String> languageLabel = Signal<String>('Français');
  final Signal<String> code = Signal<String>('fr');

  Future<void> changeLangues({required String languageCode}) async {
    final Either<Failure, LanguageEntity> result = await changeLanguageUseCase(
      LanguageParams(languageCode: languageCode),
    );

    await result.fold(
      ifLeft: (Failure failure) async {
        if (kDebugMode) {
          print(failure);
        }
      },
      ifRight: (LanguageEntity entity) async {
        final LanguagesViewModel viewModel = LanguagesViewModel(entity);
        languageLabel.value = viewModel.label;
        code.value = viewModel.languageCode;
      },
    );
  }
}
