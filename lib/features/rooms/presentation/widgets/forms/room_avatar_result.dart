import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/media/domain/entities/picked_media.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/monogram_user.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class RoomAvatarResult extends StatelessWidget {
  const new({
    required this.currentAvatarUrl,
    required this.roomName,
    this.roomDescription,
    this.pickedMedia,
    this.onPick,
    this.onRemove,
    this.isUploading = false,
    super.key
  });

  final String currentAvatarUrl;
  final String roomName;
  final String? roomDescription;
  final PickedMedia? pickedMedia;
  final VoidCallback? onPick;
  final VoidCallback? onRemove;
  final bool isUploading;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool hasAvatar = pickedMedia != null || currentAvatarUrl.isNotEmpty;

    return Center(
      child: Column(
        spacing: AppSpacing.spaceSm.value,
        children: <Widget>[
          GestureDetector(
            onTap: isUploading ? null : onPick,
            child: Stack(
              alignment: .center,
              children: <Widget>[
                MonogramUser(
                  username: roomName,
                  avatarUrl: currentAvatarUrl,
                  imageBytes: pickedMedia?.bytes,
                  size: 84
                ),
                if (isUploading)
                  Container(
                    width: 84,
                    height: 84,
                    decoration: const BoxDecoration(shape: .circle, color: Colors.black45),
                    child: const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2.5)
                      )
                    )
                  )
              ]
            )
          ),
          if (onPick != null)
            Row(
              mainAxisSize: .min,
              spacing: AppSpacing.spaceSm.value,
              children: <Widget>[
                OutlinedButton.icon(
                  onPressed: isUploading ? null : onPick,
                  icon: const Icon(Icons.photo_camera_outlined, size: 18),
                  label: Text(hasAvatar ? "Changer l'image" : 'Ajouter une image')
                ),
                if (hasAvatar && onRemove != null)
                  TextButton.icon(
                    onPressed: isUploading ? null : onRemove,
                    icon: Icon(Icons.delete_outline, size: 18, color: theme.colorScheme.error),
                    label: Text('Supprimer', style: TextStyle(color: theme.colorScheme.error))
                  )
              ]
            ),
          Text(
            'Avatar du salon',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: .w600, color: theme.colorScheme.onSurface)
          ),
          Text(
            'Sélectionnez une image ou saisissez une URL ci-dessous',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
            textAlign: .center
          )
        ]
      )
    );
  }
}
