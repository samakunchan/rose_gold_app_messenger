import 'package:package_info_plus/package_info_plus.dart';
import 'package:rose_gold_app_messenger/features/core/database/app_database.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/settings/data/datasources/gdpr_data_source.dart';
import 'package:rose_gold_app_messenger/features/settings/data/datasources/languages_data_sources.dart';
import 'package:rose_gold_app_messenger/features/settings/data/datasources/theme_mode_data_sources.dart';
import 'package:rose_gold_app_messenger/features/settings/data/repositories/gdpr_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/settings/data/repositories/languages_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/settings/data/repositories/theme_mode_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/repositories/gdpr_repository.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/repositories/languages_repository.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/repositories/theme_mode_repository.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/change_language_use_case.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/change_theme_mode_use_case.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/clear_local_cache_use_case.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/export_user_data_use_case.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/save_exported_data_use_case.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/languages_signals.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/settings_signals.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/theme_mode_signals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void initSettingsDI() {
  kGetIt
    /// Settings - Data sources
    ..registerLazySingleton<ThemeModeDataSources>(
      () => ThemeModeDataSourcesImpl(preferences: kGetIt<SharedPreferencesWithCache>()),
    )
    ..registerLazySingleton<LanguagesDataSources>(
      () => LanguagesDataSourcesImpl(preferences: kGetIt<SharedPreferencesWithCache>()),
    )
    ..registerLazySingleton<GdprDataSource>(
      () => GdprDataSourceImpl(
        supabaseClient: kGetIt<SupabaseClient>(),
        database: kGetIt<AppDatabase>(),
        preferences: kGetIt<SharedPreferencesWithCache>(),
        packageInfo: kGetIt<PackageInfo>(),
      ),
    )
    /// Settings - Repositories
    ..registerLazySingleton<ThemeModeRepository>(() => ThemeModeRepositoryImpl(dataSources: kGetIt<ThemeModeDataSources>()))
    ..registerLazySingleton<LanguagesRepository>(() => LanguagesRepositoryImpl(dataSources: kGetIt<LanguagesDataSources>()))
    ..registerLazySingleton<GdprRepository>(() => GdprRepositoryImpl(dataSource: kGetIt<GdprDataSource>()))
    /// Settings - Use cases
    ..registerLazySingleton<ChangeThemeModeUseCase>(() => ChangeThemeModeUseCase(kGetIt<ThemeModeRepository>()))
    ..registerLazySingleton<ChangeLanguageUseCase>(() => ChangeLanguageUseCase(kGetIt<LanguagesRepository>()))
    ..registerLazySingleton<ExportUserDataUseCase>(() => ExportUserDataUseCase(kGetIt<GdprRepository>()))
    ..registerLazySingleton<SaveExportedDataUseCase>(() => SaveExportedDataUseCase(kGetIt<GdprRepository>()))
    ..registerLazySingleton<ClearLocalCacheUseCase>(() => ClearLocalCacheUseCase(kGetIt<GdprRepository>()))
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
    ..registerLazySingleton<SettingsSignals>(
      () => SettingsSignals(
        exportUserDataUseCase: kGetIt<ExportUserDataUseCase>(),
        saveExportedDataUseCase: kGetIt<SaveExportedDataUseCase>(),
        clearLocalCacheUseCase: kGetIt<ClearLocalCacheUseCase>(),
      ),
    )
  //
  ;
}
