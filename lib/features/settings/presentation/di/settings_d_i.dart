import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/settings/data/datasources/languages_data_sources.dart';
import 'package:rose_gold_app_messenger/features/settings/data/datasources/theme_mode_data_sources.dart';
import 'package:rose_gold_app_messenger/features/settings/data/repositories/languages_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/settings/data/repositories/theme_mode_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/repositories/languages_repository.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/repositories/theme_mode_repository.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/change_language_use_case.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/change_theme_mode_use_case.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/languages_signals.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/theme_mode_signals.dart';
import 'package:shared_preferences/shared_preferences.dart';

void initSettingsDI() {
  kGetIt
    /// Settings
    ..registerLazySingleton<ThemeModeDataSources>(
      () => ThemeModeDataSourcesImpl(preferences: kGetIt<SharedPreferencesWithCache>()),
    )
    ..registerLazySingleton<LanguagesDataSources>(
      () => LanguagesDataSourcesImpl(preferences: kGetIt<SharedPreferencesWithCache>()),
    )
    /// Settings - Repositories
    ..registerLazySingleton<ThemeModeRepository>(() => ThemeModeRepositoryImpl(dataSources: kGetIt<ThemeModeDataSources>()))
    ..registerLazySingleton<LanguagesRepository>(() => LanguagesRepositoryImpl(dataSources: kGetIt<LanguagesDataSources>()))
    /// Settings - Use cases
    ..registerLazySingleton<ChangeThemeModeUseCase>(() => ChangeThemeModeUseCase(kGetIt<ThemeModeRepository>()))
    ..registerLazySingleton<ChangeLanguageUseCase>(() => ChangeLanguageUseCase(kGetIt<LanguagesRepository>()))
    /// Settings - Signals
    ..registerLazySingleton<ThemeModeSignals>(
      () => ThemeModeSignals(
        changeThemeModeUseCase: kGetIt<ChangeThemeModeUseCase>(),
        themeModeRepository: kGetIt<ThemeModeRepository>(),
      ),
    )
    ..registerLazySingleton<LanguagesSignals>(
      () => LanguagesSignals(
        changeLanguageUseCase: kGetIt<ChangeLanguageUseCase>(),
        languagesRepository: kGetIt<LanguagesRepository>(),
      ),
    )
  //
  ;
}
