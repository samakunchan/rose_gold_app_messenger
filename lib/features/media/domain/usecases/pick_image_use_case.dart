import 'package:dart_either/dart_either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/media/domain/entities/picked_media.dart';
import 'package:rose_gold_app_messenger/features/media/domain/repositories/media_repository.dart';

class PickImageUseCase {
  const new({required this.repository});

  final MediaRepository repository;

  Future<Either<Failure, PickedMedia?>> call({
    required ImageSource source,
    int imageQuality = 85,
  }) {
    if (source == ImageSource.camera) {
      return repository.pickImageFromCamera(imageQuality: imageQuality);
    }
    return repository.pickImageFromGallery(imageQuality: imageQuality);
  }
}
