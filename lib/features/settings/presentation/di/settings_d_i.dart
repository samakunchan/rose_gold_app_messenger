import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/settings/data/datasources/theme_mode_data_sources.dart';
import 'package:rose_gold_app_messenger/features/settings/data/repositories/theme_mode_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/repositories/theme_mode_repository.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/change_theme_mode_use_case.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/theme_mode_signals.dart';

void initSettingsDI() {
  kGetIt
    /// Settings
    ..registerLazySingleton<ThemeModeDataSources>(ThemeModeDataSourcesImpl.new)
    /// Settings - Repositories
    ..registerLazySingleton<ThemeModeRepository>(() => ThemeModeRepositoryImpl(dataSources: kGetIt<ThemeModeDataSources>()))
    /// Settings - Use cases
    ..registerLazySingleton<ChangeThemeModeUseCase>(() => ChangeThemeModeUseCase(kGetIt<ThemeModeRepository>()))
    /// Settings - Signals
    ..registerLazySingleton<ThemeModeSignals>(
      () => ThemeModeSignals(changeThemeModeUseCase: kGetIt<ChangeThemeModeUseCase>()),
    )
  //
  ;
}
