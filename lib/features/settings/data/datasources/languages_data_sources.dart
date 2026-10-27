import 'package:rose_gold_app_messenger/features/settings/data/models/language_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LanguagesDataSources {
  Future<LanguageModel> changeLanguage({required String languageCode});
  LanguageModel getSavedLanguage();
}

class LanguagesDataSourcesImpl implements LanguagesDataSources {
  new({required this.preferences});

  static const String _languageKey = 'local_language';
  final SharedPreferencesWithCache preferences;

  LanguageModel _fromCode(String languageCode) {
    return switch (languageCode) {
      'fr' => LanguageModel(label: 'Français', languageCode: 'fr'),
      'en' => LanguageModel(label: 'English', languageCode: 'en'),
      'es' => LanguageModel(label: 'Español', languageCode: 'es'),
      _ => LanguageModel(label: 'Français', languageCode: 'fr'),
    };
  }

  @override
  Future<LanguageModel> changeLanguage({required String languageCode}) async {
    final LanguageModel language = _fromCode(languageCode);
    await preferences.setString(_languageKey, language.languageCode);

    return language;
  }

  @override
  LanguageModel getSavedLanguage() {
    final String savedCode = preferences.getString(_languageKey) ?? 'fr';

    return _fromCode(savedCode);
  }
}
