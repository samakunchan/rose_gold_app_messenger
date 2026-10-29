import 'package:dart_either/dart_either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/media/domain/entities/picked_media.dart';
import 'package:rose_gold_app_messenger/features/media/domain/usecases/pick_image_use_case.dart';
import 'package:rose_gold_app_messenger/features/media/domain/usecases/pick_video_use_case.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class AppMediaPickerBottomSheet extends StatelessWidget {
  const new({
    this.title = 'Choisir un média',
    this.allowVideo = false,
    this.cameraLabel = 'Prendre une photo',
    this.galleryPhotoLabel = 'Choisir une photo',
    this.galleryVideoLabel = 'Choisir une vidéo',
    super.key,
  });

  final String title;
  final bool allowVideo;
  final String cameraLabel;
  final String galleryPhotoLabel;
  final String galleryVideoLabel;

  static Future<PickedMedia?> show(
    BuildContext context, {
    String title = 'Choisir un média',
    bool allowVideo = false,
    String cameraLabel = 'Prendre une photo',
    String galleryPhotoLabel = 'Choisir une photo',
    String galleryVideoLabel = 'Choisir une vidéo',
  }) {
    return showModalBottomSheet<PickedMedia?>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => AppMediaPickerBottomSheet(
        title: title,
        allowVideo: allowVideo,
        cameraLabel: cameraLabel,
        galleryPhotoLabel: galleryPhotoLabel,
        galleryVideoLabel: galleryVideoLabel,
      ),
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final PickImageUseCase useCase = kGetIt<PickImageUseCase>();
    final Either<Failure, PickedMedia?> result = await useCase(source: source);
    if (context.mounted) {
      final PickedMedia? media = result.fold(
        ifLeft: (_) => null,
        ifRight: (PickedMedia? m) => m,
      );
      Navigator.of(context).pop(media);
    }
  }

  Future<void> _pickVideo(BuildContext context) async {
    final PickVideoUseCase useCase = kGetIt<PickVideoUseCase>();
    final Either<Failure, PickedMedia?> result = await useCase();
    if (context.mounted) {
      final PickedMedia? media = result.fold(
        ifLeft: (_) => null,
        ifRight: (PickedMedia? m) => m,
      );
      Navigator.of(context).pop(media);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: .vertical(top: .circular(AppRadius.dialog.value)),
      clipBehavior: .antiAlias,
      child: Padding(
        padding: .only(
          top: AppSpacing.spaceMd.value,
          bottom: AppSpacing.spaceLg.value,
          left: AppSpacing.spaceMd.value,
          right: AppSpacing.spaceMd.value,
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: .min,
            children: <Widget>[
              Container(
                width: 40,
                height: 4,
                margin: .only(bottom: AppSpacing.spaceMd.value),
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant,
                  borderRadius: .circular(2),
                ),
              ),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: .bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.camera_alt_rounded, color: theme.colorScheme.primary),
                title: Text(cameraLabel),
                onTap: () => _pickImage(context, ImageSource.camera),
              ),
              ListTile(
                leading: Icon(Icons.photo_library_rounded, color: theme.colorScheme.primary),
                title: Text(galleryPhotoLabel),
                onTap: () => _pickImage(context, ImageSource.gallery),
              ),
              if (allowVideo)
                ListTile(
                  leading: Icon(Icons.videocam_rounded, color: theme.colorScheme.primary),
                  title: Text(galleryVideoLabel),
                  onTap: () => _pickVideo(context),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
