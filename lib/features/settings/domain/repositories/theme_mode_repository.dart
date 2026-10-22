import 'package:dart_either/dart_either.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/params.dart';

abstract class ThemeModeRepository {
  Future<Either<Failure, ThemeMode>> changeThemeMode({required ThemeModeParams params});
}
