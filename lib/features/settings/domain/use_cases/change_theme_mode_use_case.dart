import 'package:dart_either/dart_either.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/repositories/theme_mode_repository.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/params.dart';

/// Accepter une invitation à entrer dans un salon.
class ChangeThemeModeUseCase {
  new(this.repository);
  final ThemeModeRepository repository;

  Future<Either<Failure, ThemeMode>> call(ThemeModeParams params) async {
    return await repository.changeThemeMode(params: params);
  }
}
