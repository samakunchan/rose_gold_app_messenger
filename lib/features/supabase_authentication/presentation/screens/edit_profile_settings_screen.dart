import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/core/errors/show_errors_sheet.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/widgets/auth_top_header.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class EditProfileSettingScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<EditProfileSettingScreen> createState() => _EditProfileSettingScreenState();
}

class _EditProfileSettingScreenState extends State<EditProfileSettingScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _avatarUrlController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  late final FlutterSignal<bool> _canSubmit = signal(false);

  @override
  void initState() {
    super.initState();
    final AuthSignals authSignals = kGetIt<AuthSignals>();
    _usernameController.text = authSignals.userConnectedName.value ?? '';
    _avatarUrlController.text = authSignals.userConnectedAvatarUrl.value ?? '';
    _phoneController.text = authSignals.userConnectedPhone.value ?? '';

    _usernameController.addListener(_validateForm);
    _avatarUrlController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _usernameController.removeListener(_validateForm);
    _avatarUrlController.removeListener(_validateForm);
    _phoneController.removeListener(_validateForm);
    _usernameController.dispose();
    _avatarUrlController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AuthSignals authSignals = kGetIt<AuthSignals>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: .all(AppSpacing.spaceBase.value),
          child: Column(
            crossAxisAlignment: .stretch,
            spacing: AppSpacing.spaceBase.value,
            children: <Widget>[
              const AuthTopHeader(),
              Text(
                'Modifier mon profil',
                style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4),
              ),
              Text(
                'Mettez à jour vos informations visibles par les membres de vos salons.',
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4),
              ),
              Column(
                crossAxisAlignment: .start,
                spacing: AppSpacing.spaceXs.value,
                children: <Widget>[
                  const Text('PSEUDO'),
                  TextField(
                    controller: _usernameController,
                    textInputAction: .next,
                    decoration: const InputDecoration(
                      hintText: 'Votre pseudo',
                      prefixIcon: Icon(Icons.person_outline, size: 20),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: .start,
                spacing: AppSpacing.spaceXs.value,
                children: <Widget>[
                  const Text('URL DE L’AVATAR'),
                  TextField(
                    controller: _avatarUrlController,
                    keyboardType: .url,
                    textInputAction: .next,
                    decoration: const InputDecoration(
                      hintText: 'https://...',
                      prefixIcon: Icon(Icons.image_outlined, size: 20),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: .start,
                spacing: AppSpacing.spaceXs.value,
                children: <Widget>[
                  const Text('TÉLÉPHONE'),
                  TextField(
                    controller: _phoneController,
                    keyboardType: .phone,
                    textInputAction: .done,
                    decoration: const InputDecoration(
                      hintText: '+33 6 00 00 00 00',
                      prefixIcon: Icon(Icons.phone_outlined, size: 20),
                    ),
                  ),
                ],
              ),
              SignalBuilder(
                builder: (_) {
                  final bool isLoading = authSignals.isLoading.value;
                  final bool canSubmit = _canSubmit.value && !isLoading;

                  return ElevatedButton.icon(
                    iconAlignment: .end,
                    onPressed: canSubmit ? _handleSubmitProfile : null,
                    icon: isLoading
                        ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.check, size: 18),
                    label: Text(isLoading ? 'Enregistrement en cours...' : 'Enregistrer les modifications'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateForm() {
    final AuthSignals authSignals = kGetIt<AuthSignals>();
    final String username = _usernameController.text.trim();
    final String avatarUrl = _avatarUrlController.text.trim();
    final String phone = _phoneController.text.trim();

    final bool hasChanged =
        username != (authSignals.userConnectedName.value ?? '') ||
        avatarUrl != (authSignals.userConnectedAvatarUrl.value ?? '') ||
        phone != (authSignals.userConnectedPhone.value ?? '');

    _canSubmit.value = username.isNotEmpty && hasChanged;
  }

  Future<void> _handleSubmitProfile() async {
    final AuthSignals authSignals = kGetIt<AuthSignals>();

    final bool success = await authSignals.updateProfile(
      username: _usernameController.text.trim(),
      avatarUrl: _avatarUrlController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
    );

    if (!mounted) {
      return;
    }

    if (!success && authSignals.authError.value != null) {
      showErrorSheet(context: context, title: 'Erreur', message: authSignals.authError.value!);
    } else if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil mis à jour avec succès !'), behavior: .floating),
      );
      Navigator.of(context).pop();
    }
  }
}
