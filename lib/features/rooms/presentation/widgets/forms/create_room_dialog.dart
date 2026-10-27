import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/core/errors/show_errors_sheet.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/rooms_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/forms/room_description_text_field.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/forms/room_name_text_field.dart';
import 'package:rose_gold_app_messenger/themes/extensions/rooms_theme_extension.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class CreateRoomDialog extends StatefulWidget {
  const new({this.roomsSignals, super.key});

  final RoomsSignals? roomsSignals;

  @override
  State<CreateRoomDialog> createState() => _CreateRoomDialogState();
}

class _CreateRoomDialogState extends State<CreateRoomDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final RoomsSignals roomsSignals = widget.roomsSignals ?? kGetIt<RoomsSignals>();
    final String name = _nameController.text.trim();
    final String description = _descriptionController.text.trim();

    await roomsSignals.createRoom(
      name: name,
      description: description.isNotEmpty ? description : null,
    );

    if (!mounted) return;

    if (roomsSignals.isRoomCreated.value) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Salon "$name" créé avec succès !'),
          behavior: .floating,
        ),
      );
    } else {
      showErrorSheet(
        context: context,
        title: 'Erreur',
        message: 'Impossible de créer le salon. Veuillez réessayer.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final RoomsSignals roomsSignals = widget.roomsSignals ?? kGetIt<RoomsSignals>();
    final ThemeData theme = Theme.of(context);
    final RoomsThemeExtension roomsTheme = theme.extension<RoomsThemeExtension>() ?? .light;

    return SignalBuilder(
      builder: (_) {
        final bool isLoading = roomsSignals.isLoading.value;

        return AlertDialog(
          title: Row(
            spacing: AppSpacing.spaceSm.value,
            children: <Widget>[
              Icon(Icons.meeting_room_outlined, color: theme.colorScheme.primary),
              const Text('Créer un salon'),
            ],
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: .min,
                spacing: AppSpacing.spaceBase.value,
                children: <Widget>[
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
                    onFieldSubmitted: (_) => _handleSubmit(),
                    onChanged: (_) => setState(() {}),
                    onClear: () => setState(_descriptionController.clear),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            OutlinedButton(
              style: roomsTheme.primaryOutlinedDecorationButton,
              onPressed: isLoading ? null : Navigator.of(context).pop,
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              style: roomsTheme.secondaryDecorationButton,
              onPressed: isLoading ? null : _handleSubmit,
              child: isLoading ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Créer'),
            ),
          ],
        );
      },
    );
  }
}
