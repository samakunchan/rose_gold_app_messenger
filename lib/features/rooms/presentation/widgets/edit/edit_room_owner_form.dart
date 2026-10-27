import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/core/errors/show_errors_sheet.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/rooms_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/forms/room_avatar_result.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/forms/room_avatar_text_field.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/forms/room_description_text_field.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/forms/room_name_text_field.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/forms/zone_danger_actions.dart';
import 'package:rose_gold_app_messenger/themes/extensions/rooms_theme_extension.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class EditRoomOwnerForm extends StatefulWidget {
  const new({required this.roomId, required this.initialName, this.initialDescription, this.initialAvatarUrl, this.roomsSignals, super.key});

  final String roomId;
  final String initialName;
  final String? initialDescription;
  final String? initialAvatarUrl;
  final RoomsSignals? roomsSignals;

  @override
  State<EditRoomOwnerForm> createState() => _EditRoomOwnerFormState();
}

class _EditRoomOwnerFormState extends State<EditRoomOwnerForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _avatarUrlController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _descriptionController = TextEditingController(text: widget.initialDescription ?? '');
    _avatarUrlController = TextEditingController(text: widget.initialAvatarUrl ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _avatarUrlController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final RoomsSignals roomsSignals = widget.roomsSignals ?? kGetIt<RoomsSignals>();
    final String name = _nameController.text.trim();
    final String description = _descriptionController.text.trim();
    final String avatarUrl = _avatarUrlController.text.trim();

    await roomsSignals.updateRoom(
      roomId: widget.roomId,
      name: name,
      description: description.isNotEmpty ? description : null,
      avatarUrl: avatarUrl.isNotEmpty ? avatarUrl : null,
    );

    if (!mounted) return;

    if (roomsSignals.isRoomUpdated.value) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Salon "$name" mis à jour avec succès !'),
          behavior: .floating,
        ),
      );
    } else {
      showErrorSheet(
        context: context,
        title: 'Erreur',
        message: 'Impossible de modifier le salon. Veuillez réessayer.',
      );
    }
  }

  Future<void> _confirmDelete() async {
    final ThemeData theme = Theme.of(context);
    final RoomsSignals roomsSignals = widget.roomsSignals ?? kGetIt<RoomsSignals>();

    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('Supprimer ce salon ?'),
        content: const Text(
          'Cette action est irréversible. Toutes les données et messages associés seront définitivement effacés.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: theme.colorScheme.error),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      await roomsSignals.deleteRooms(roomId: widget.roomId);
      if (mounted) {
        Navigator.of(context).popUntil((Route<dynamic> route) => route.isFirst);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final RoomsThemeExtension roomsTheme = theme.extension<RoomsThemeExtension>() ?? .light;
    final RoomsSignals roomsSignals = widget.roomsSignals ?? kGetIt<RoomsSignals>();

    return SignalBuilder(
      builder: (_) {
        final bool isLoading = roomsSignals.isLoading.value;

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: .start,
            spacing: AppSpacing.spaceXl.value,
            children: <Widget>[
              /// Section Avatar du salon
              RoomAvatarResult(
                roomName: _nameController.text,
                currentAvatarUrl: _avatarUrlController.text,
              ),

              // Champs de saisie
              Column(
                crossAxisAlignment: .start,
                spacing: AppSpacing.spaceMd.value,
                children: <Widget>[
                  /// URL de l'avatar
                  RoomAvatarTextField(
                    avatarUrlController: _avatarUrlController,
                    isLoading: isLoading,
                    onChanged: (_) => setState(() {}),
                    onClear: () => setState(_avatarUrlController.clear),
                  ),

                  /// Nom du salon
                  RoomNameTextField(
                    nameController: _nameController,
                    isLoading: isLoading,
                    onChanged: (_) => setState(() {}),
                    onClear: () => setState(_nameController.clear),
                  ),

                  /// Description du salon
                  RoomDescriptionTextField(
                    descriptionController: _descriptionController,
                    isLoading: isLoading,
                    onFieldSubmitted: (_) => _handleSave(),
                    onChanged: (_) => setState(() {}),
                    onClear: () => setState(_descriptionController.clear),
                  ),
                ],
              ),

              // Bouton Enregistrer
              SizedBox(
                width: .infinity,
                height: 50,
                child: ElevatedButton(
                  style: roomsTheme.primaryDecorationButton,
                  onPressed: isLoading ? null : _handleSave,
                  child: isLoading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(
                          'Enregistrer les modifications',
                          style: theme.textTheme.labelLarge?.copyWith(fontWeight: .bold, color: roomsTheme.primaryTextColor),
                        ),
                ),
              ),

              const Divider(),
              // Au bottom pour l'Owner : Zone de danger Supprimer le salon
              ZoneDangerActions(
                title: 'Supprimer le salon',
                description: 'La suppression de ce salon est irréversible et supprimera le salon pour l’ensemble des membres.',
                titleButton: 'Supprimer ce salon',
                onPressed: isLoading ? null : _confirmDelete,
              ),
            ],
          ),
        );
      },
    );
  }
}
