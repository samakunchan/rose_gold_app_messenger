import 'package:rose_gold_app_messenger/features/settings/data/models/language_model.dart';

abstract class LanguagesDataSources {
  Future<LanguageModel> changeLanguage({required String languageCode});
}

class LanguagesDataSourcesImpl implements LanguagesDataSources {
  @override
  Future<LanguageModel> changeLanguage({required String languageCode}) async {
    final LanguageModel language = switch (languageCode) {
      'fr' => LanguageModel(label: 'Français', languageCode: 'fr'),
      'en' => LanguageModel(label: 'English', languageCode: 'en'),
      'es' => LanguageModel(label: 'Español', languageCode: 'es'),
      _ => LanguageModel(label: 'English (fallback)', languageCode: 'en'),
    };

    return language;
  }
}
