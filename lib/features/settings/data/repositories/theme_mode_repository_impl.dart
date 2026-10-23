import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/settings/data/datasources/theme_mode_data_sources.dart';
import 'package:rose_gold_app_messenger/features/settings/data/models/theme_mode_model.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/entities/theme_mode_entity.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/repositories/theme_mode_repository.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/params.dart';

class ThemeModeRepositoryImpl implements ThemeModeRepository {
  new({required this.dataSources});
  final ThemeModeDataSources dataSources;

  @override
  Future<Either<Failure, ThemeModeEntity>> changeThemeMode({required ThemeModeParams params}) async {
    try {
      final ThemeModeModel themeMode = await dataSources.changeThemeMode(themeMode: params.selectedThemeMode);
      return Right<Failure, ThemeModeEntity>(themeMode.toEntity());
    } on Exception {
      return const Left<Failure, ThemeModeEntity>(SettingsFailure());
    }
  }
}
