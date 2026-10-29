import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/media/data/datasources/media_picker_data_source.dart';
import 'package:rose_gold_app_messenger/features/media/data/datasources/media_storage_data_source.dart';
import 'package:rose_gold_app_messenger/features/media/data/repositories/media_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/media/domain/repositories/media_repository.dart';
import 'package:rose_gold_app_messenger/features/media/domain/usecases/pick_image_use_case.dart';
import 'package:rose_gold_app_messenger/features/media/domain/usecases/pick_video_use_case.dart';
import 'package:rose_gold_app_messenger/features/media/domain/usecases/upload_public_avatar_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void initMediaDI() {
  kGetIt
    /// Data sources
    ..registerLazySingleton<MediaPickerDataSource>(MediaPickerDataSourceImpl.new)
    ..registerLazySingleton<MediaStorageDataSource>(
      () => MediaStorageDataSourceImpl(client: kGetIt<SupabaseClient>()),
    )
    /// Repository
    ..registerLazySingleton<MediaRepository>(
      () => MediaRepositoryImpl(
        pickerDataSource: kGetIt<MediaPickerDataSource>(),
        storageDataSource: kGetIt<MediaStorageDataSource>(),
      ),
    )
    /// Use cases
    ..registerLazySingleton<PickImageUseCase>(
      () => PickImageUseCase(repository: kGetIt<MediaRepository>()),
    )
    ..registerLazySingleton<PickVideoUseCase>(
      () => PickVideoUseCase(repository: kGetIt<MediaRepository>()),
    )
    ..registerLazySingleton<UploadPublicAvatarUseCase>(
      () => UploadPublicAvatarUseCase(repository: kGetIt<MediaRepository>()),
    );
}
