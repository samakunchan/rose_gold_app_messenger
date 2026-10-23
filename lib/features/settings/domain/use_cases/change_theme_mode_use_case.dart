import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/entities/theme_mode_entity.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/repositories/theme_mode_repository.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/params.dart';

/// Changement de luminosité de l'écran.
class ChangeThemeModeUseCase {
  new(this.repository);
  final ThemeModeRepository repository;

  Future<Either<Failure, ThemeModeEntity>> call(ThemeModeParams params) async {
    return await repository.changeThemeMode(params: params);
  }
}
