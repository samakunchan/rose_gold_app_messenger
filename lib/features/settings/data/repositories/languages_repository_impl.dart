import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/settings/data/datasources/languages_data_sources.dart';
import 'package:rose_gold_app_messenger/features/settings/data/models/language_model.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/entities/language_entity.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/repositories/languages_repository.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/params.dart';

class LanguagesRepositoryImpl implements LanguagesRepository {
  new({required this.dataSources});
  final LanguagesDataSources dataSources;

  @override
  Future<Either<Failure, LanguageEntity>> changeLanguages({required LanguageParams params}) async {
    try {
      final LanguageModel language = await dataSources.changeLanguage(languageCode: params.languageCode);
      return Right<Failure, LanguageEntity>(language.toEntity());
    } on Exception {
      return const Left<Failure, LanguageEntity>(SettingsFailure());
    }
  }
}
