import 'dart:async';

import 'package:dart_either/dart_either.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/core/errors/show_errors_sheet.dart';
import 'package:rose_gold_app_messenger/features/media/domain/entities/picked_media.dart';
import 'package:rose_gold_app_messenger/features/media/domain/usecases/upload_public_avatar_use_case.dart';
import 'package:rose_gold_app_messenger/features/media/presentation/widgets/app_media_picker_bottom_sheet.dart';
import 'package:rose_gold_app_messenger/features/profile/presentation/signals/profile_signals.dart';
import 'package:rose_gold_app_messenger/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/widgets/widgets_export.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfileSettingScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<EditProfileSettingScreen> createState() => _EditProfileSettingScreenState();
}

class _EditProfileSettingScreenState extends State<EditProfileSettingScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  late final FlutterSignal<bool> _canSubmit = signal(false);
  late final FlutterSignal<bool> _isUploading = signal(false);

  String? _currentAvatarUrl;
  PickedMedia? _pickedAvatarMedia;
  bool _avatarRemoved = false;

  @override
  void initState() {
    super.initState();
    final AuthSignals authSignals = kGetIt<AuthSignals>();
    final ProfileSignals profileSignals = kGetIt<ProfileSignals>();
    final SupabaseClient supabase = kGetIt<SupabaseClient>();
    final String? currentUserId = supabase.auth.currentUser?.id;

    _usernameController.text = authSignals.userConnectedName.value ?? '';
    _currentAvatarUrl = authSignals.userConnectedAvatarUrl.value;
    _phoneController.text = authSignals.userConnectedPhone.value ?? '';

    if (currentUserId != null) {
      unawaited(
        profileSignals.fetchProfile(userId: currentUserId).then((_) {
          final ProfileViewModel? profile = profileSignals.currentProfile.value;
          if (profile != null && mounted) {
            setState(() {
              _usernameController.text = profile.username;
              _currentAvatarUrl = profile.avatarUrl;
              _phoneController.text = profile.phone ?? '';
            });
            _validateForm();
          }
        }),
      );
    }

    _usernameController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _usernameController.removeListener(_validateForm);
    _phoneController.removeListener(_validateForm);
    _usernameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AuthSignals authSignals = kGetIt<AuthSignals>();
    final ProfileSignals profileSignals = kGetIt<ProfileSignals>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: .all(AppSpacing.spaceBase.value),
          child: Column(
            crossAxisAlignment: .stretch,
            spacing: AppSpacing.spaceBase.value,
            children: <Widget>[
              const AuthTopHeader(),
              Text('Modifier mon profil', style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4)),
              Text(
                'Mettez à jour vos informations visibles par les membres de vos salons.',
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4),
              ),
              SignalBuilder(
                builder: (_) => ProfileAvatarPicker(
                  username: _usernameController.text.trim().isNotEmpty
                      ? _usernameController.text.trim()
                      : (authSignals.userConnectedName.value ?? ''),
                  avatarUrl: _currentAvatarUrl,
                  pickedMedia: _pickedAvatarMedia,
                  isUploading: _isUploading.value,
                  onPick: _handlePickAvatar,
                  onRemove: (_currentAvatarUrl != null && _currentAvatarUrl!.isNotEmpty) || _pickedAvatarMedia != null
                      ? _handleRemoveAvatar
                      : null,
                ),
              ),
              Column(
                crossAxisAlignment: .start,
                spacing: AppSpacing.spaceXs.value,
                children: <Widget>[
                  const Text('PSEUDO'),
                  TextField(
                    controller: _usernameController,
                    textInputAction: .next,
                    decoration: const InputDecoration(hintText: 'Votre pseudo', prefixIcon: Icon(Icons.person_outline, size: 20)),
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
                    decoration: const InputDecoration(hintText: '+33 6 00 00 00 00', prefixIcon: Icon(Icons.phone_outlined, size: 20)),
                  ),
                ],
              ),
              SignalBuilder(
                builder: (_) {
                  final bool isLoading = profileSignals.isLoading.value || authSignals.isLoading.value || _isUploading.value;
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
    final ProfileSignals profileSignals = kGetIt<ProfileSignals>();
    final AuthSignals authSignals = kGetIt<AuthSignals>();
    final String username = _usernameController.text.trim();
    final String phone = _phoneController.text.trim();

    final String initialUsername = profileSignals.currentProfile.value?.username ?? authSignals.userConnectedName.value ?? '';
    final String initialAvatar = profileSignals.currentProfile.value?.avatarUrl ?? authSignals.userConnectedAvatarUrl.value ?? '';
    final String initialPhone = profileSignals.currentProfile.value?.phone ?? authSignals.userConnectedPhone.value ?? '';

    final bool avatarChanged = _pickedAvatarMedia != null || (_avatarRemoved && initialAvatar.isNotEmpty);
    final bool hasChanged = username != initialUsername || avatarChanged || phone != initialPhone;

    _canSubmit.value = username.isNotEmpty && hasChanged;
  }

  Future<void> _handlePickAvatar() async {
    final PickedMedia? media = await AppMediaPickerBottomSheet.show(context, title: 'Photo de profil');

    if (media == null || !mounted) {
      return;
    }

    setState(() {
      _pickedAvatarMedia = media;
      _avatarRemoved = false;
    });
    _validateForm();
  }

  void _handleRemoveAvatar() {
    setState(() {
      _pickedAvatarMedia = null;
      _avatarRemoved = true;
      _currentAvatarUrl = null;
    });
    _validateForm();
  }

  Future<void> _handleSubmitProfile() async {
    final ProfileSignals profileSignals = kGetIt<ProfileSignals>();
    final AuthSignals authSignals = kGetIt<AuthSignals>();
    final SupabaseClient supabase = kGetIt<SupabaseClient>();
    final String? currentUserId = supabase.auth.currentUser?.id;

    if (currentUserId == null) {
      return;
    }

    String? finalAvatarUrl = _currentAvatarUrl;

    if (_avatarRemoved) {
      finalAvatarUrl = '';
    } else if (_pickedAvatarMedia != null) {
      _isUploading.value = true;
      final UploadPublicAvatarUseCase uploadAvatarUseCase = kGetIt<UploadPublicAvatarUseCase>();
      final Either<Failure, String> uploadResult = await uploadAvatarUseCase(
        bytes: _pickedAvatarMedia!.bytes,
        fileExtension: _pickedAvatarMedia!.fileExtension,
        mimeType: _pickedAvatarMedia!.mimeType,
      );
      _isUploading.value = false;

      final (Failure? failure, String? uploadedUrl) = uploadResult.fold(ifLeft: (Failure f) => (f, null), ifRight: (String url) => (null, url));

      if (failure != null || uploadedUrl == null) {
        if (mounted) {
          showErrorSheet(context: context, title: 'Erreur', message: failure?.message ?? 'Échec du téléversement de la photo de profil');
        }
        return;
      }

      finalAvatarUrl = uploadedUrl;
    }

    final bool success = await profileSignals.updateProfile(
      userId: currentUserId,
      username: _usernameController.text.trim(),
      avatarUrl: finalAvatarUrl,
      phone: _phoneController.text.trim(),
    );

    if (!mounted) {
      return;
    }

    if (!success && profileSignals.errorMessage.value != null) {
      showErrorSheet(context: context, title: 'Erreur', message: profileSignals.errorMessage.value!);
    } else if (success) {
      if (finalAvatarUrl != null) {
        authSignals.userConnectedAvatarUrl.value = finalAvatarUrl;
      }
      authSignals.userConnectedName.value = _usernameController.text.trim();
      authSignals.userConnectedPhone.value = _phoneController.text.trim();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil mis à jour avec succès !'), behavior: .floating));
      Navigator.of(context).pop();
    }
  }
}
