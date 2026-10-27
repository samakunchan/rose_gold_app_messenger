import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/entities/language_entity.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/repositories/languages_repository.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/params.dart';

/// Changement de langage.
class ChangeLanguageUseCase {
  new(this.repository);
  final LanguagesRepository repository;

  Future<Either<Failure, LanguageEntity>> call(LanguageParams params) async {
    return await repository.changeLanguages(params: params);
  }
}
