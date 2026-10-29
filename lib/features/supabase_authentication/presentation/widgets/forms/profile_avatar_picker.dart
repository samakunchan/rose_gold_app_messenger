import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/media/domain/entities/picked_media.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/monogram_user.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class ProfileAvatarPicker extends StatelessWidget {
  const new({
    required this.onPick,
    required this.username,
    this.avatarUrl,
    this.pickedMedia,
    this.size = 72,
    this.isUploading = false,
    this.onRemove,
    super.key,
  });

  final String username;
  final String? avatarUrl;
  final PickedMedia? pickedMedia;
  final double size;
  final bool isUploading;
  final VoidCallback onPick;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool hasAvatar = pickedMedia != null || (avatarUrl != null && avatarUrl!.isNotEmpty);

    return Column(
      crossAxisAlignment: .start,
      spacing: AppSpacing.spaceXs.value,
      children: <Widget>[
        const Text('PHOTO DE PROFIL'),
        Row(
          spacing: AppSpacing.spaceMd.value,
          children: <Widget>[
            GestureDetector(
              onTap: isUploading ? null : onPick,
              child: Stack(
                alignment: .center,
                children: <Widget>[
                  MonogramUser(username: username, avatarUrl: avatarUrl, imageBytes: pickedMedia?.bytes, size: size),
                  if (isUploading)
                    Container(
                      width: size,
                      height: size,
                      decoration: const BoxDecoration(shape: .circle, color: Colors.black45),
                      child: const Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2.5))),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Wrap(
                spacing: AppSpacing.spaceSm.value,
                runSpacing: AppSpacing.spaceXs.value,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  OutlinedButton.icon(
                    onPressed: isUploading ? null : onPick,
                    icon: const Icon(Icons.photo_camera_outlined, size: 18),
                    label: Text(hasAvatar ? 'Changer' : 'Ajouter une photo'),
                  ),
                  if (hasAvatar && onRemove != null)
                    TextButton.icon(
                      onPressed: isUploading ? null : onRemove,
                      icon: Icon(Icons.delete_outline, size: 18, color: theme.colorScheme.error),
                      label: Text('Supprimer', style: TextStyle(color: theme.colorScheme.error)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
