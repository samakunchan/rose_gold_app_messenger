import 'package:dart_either/dart_either.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/settings/data/datasources/theme_mode_data_sources.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/repositories/theme_mode_repository.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/params.dart';

class ThemeModeRepositoryImpl implements ThemeModeRepository {
  new({required this.dataSources});
  final ThemeModeDataSources dataSources;

  @override
  Future<Either<Failure, ThemeMode>> changeThemeMode({required ThemeModeParams params}) async {
    try {
      final ThemeMode themeMode = await dataSources.changeThemeMode(themeMode: params.selectedThemeMode);
      return Right<Failure, ThemeMode>(themeMode);
    } on Exception {
      return const Left<Failure, ThemeMode>(SettingsFailure());
    }
  }
}
