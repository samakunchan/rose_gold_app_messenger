import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/media/domain/entities/picked_media.dart';
import 'package:rose_gold_app_messenger/features/media/domain/repositories/media_repository.dart';

class PickVideoUseCase {
  const new({required this.repository});

  final MediaRepository repository;

  Future<Either<Failure, PickedMedia?>> call() {
    return repository.pickVideoFromGallery();
  }
}
