import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/controllers/auth_field_controller.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/widgets/forms/password_text_field.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/widgets/show_auth_errors_sheet.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AuthRegisterForm extends StatefulWidget {
  const new({required this.onCreateAccount, super.key});

  final Future<void> Function({
    required String email,
    required String password,
    required String username,
    String? invitationCode,
    bool acceptCharter,
  })
  onCreateAccount;

  @override
  State<AuthRegisterForm> createState() => _AuthRegisterFormState();
}

class _AuthRegisterFormState extends State<AuthRegisterForm> {
  bool _acceptCharter = false;

  final AuthFieldController _fields = AuthFieldController();

  @override
  void dispose() {
    _fields.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final FrontThemeExtension frontTheme = theme.extension<FrontThemeExtension>() ?? .light;
    final TextStyle? textStyle = theme.textTheme.labelSmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
      letterSpacing: 1.2,
      fontWeight: .w600,
    );

    return Column(
      crossAxisAlignment: .stretch,
      spacing: AppSpacing.spaceBase.value,
      children: <Widget>[
        // Display Name / Pseudonym Field
        SignalBuilder(
          builder: (_) => Column(
            crossAxisAlignment: .start,
            spacing: AppSpacing.spaceXs.value,
            children: <Widget>[
              Text('NOM D’USAGE OU PSEUDONYME', style: textStyle),
              TextField(
                controller: _fields.nameController,
                textCapitalization: .words,
                onChanged: (String value) => _fields.name.value = value,
                decoration: InputDecoration(
                  hintText: 'Ex: Jean Dupont',
                  prefixIcon: const Icon(Icons.person_outline, size: 20),
                  errorText: _fields.name.value.isNotEmpty && !_fields.isNameValid.value ? '2 caractères minimum requis' : null,
                ),
              ),
            ],
          ),
        ),

        // Identifier Field (Mobile or Email)
        SignalBuilder(
          builder: (_) => Column(
            crossAxisAlignment: .start,
            spacing: AppSpacing.spaceXs.value,
            children: <Widget>[
              Text('EMAIL', style: textStyle),
              TextField(
                controller: _fields.identifierController,
                keyboardType: .emailAddress,
                onChanged: (String value) => _fields.identifier.value = value,
                decoration: InputDecoration(
                  hintText: 'votre.nom@email.com',
                  prefixIcon: const Icon(Icons.alternate_email, size: 20),
                  errorText: _fields.identifier.value.isNotEmpty && !_fields.isEmailValid.value ? 'Un email valide svp' : null,
                ),
              ),
            ],
          ),
        ),

        // Confidential Code / Password Field
        SignalBuilder(
          builder: (_) => PasswordTextField(
            controller: _fields.passwordController,
            text: 'MOT DE PASSE',
            hintText: '6 caractères minimum',
            onChanged: (String value) => _fields.password.value = value,
          ),
        ),
        // Confirm Password Field
        SignalBuilder(
          builder: (_) => PasswordTextField(
            controller: _fields.confirmPasswordController,
            text: 'CONFIRMER LE MOT DE PASSE',
            hintText: 'Confirmez votre mot de passe',
            errorText: errorPasswordText(),
            onChanged: (String value) => _fields.confirmPassword.value = value,
          ),
        ),

        // Privilege Invitation Code Field (Optional)
        Column(
          crossAxisAlignment: .start,
          spacing: AppSpacing.spaceXs.value,
          children: <Widget>[
            Row(
              mainAxisAlignment: .spaceBetween,
              children: <Widget>[
                Text('CODE D’INVITATION PRIVILÉGIÉ', style: textStyle),
                Text(
                  'OPTIONNEL',
                  style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.secondary, letterSpacing: 1, fontWeight: .w500),
                ),
              ],
            ),
            TextField(
              controller: _fields.inviteCodeController,
              textCapitalization: .characters,
              decoration: const InputDecoration(hintText: 'Ex: ROSE-GOLD-VIP-2026', prefixIcon: Icon(Icons.card_membership_outlined, size: 20)),
            ),
          ],
        ),

        // Privacy & Sanctuary Encryption Charter Acceptance
        SignalBuilder(
          builder: (_) => Row(
            crossAxisAlignment: .start,
            spacing: AppSpacing.spaceXs.value,
            children: <Widget>[
              Checkbox(
                value: _acceptCharter,
                onChanged: (bool? val) {
                  setState(() {
                    _acceptCharter = val ?? false;
                  });
                  if (_acceptCharter) {
                    _fields.errorAcceptCharter.value = true;
                  }
                },
              ),
              Expanded(
                child: Padding(
                  padding: .only(top: AppSpacing.spaceSm.value),
                  child: Text.rich(
                    TextSpan(
                      text: 'J’accepte la Charte de confidentialité et le Chiffrement Sanctuaire de RoseGold.',
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4),
                      children: <InlineSpan>[
                        if (!_fields.errorAcceptCharter.value)
                          TextSpan(
                            text: '\nVeuillez accepter la charte de confidentialité.',
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error, height: 1.4),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Primary Action Button
        SignalBuilder(
          builder: (_) => ElevatedButton.icon(
            style: frontTheme.elevatedButtonStyle,
            iconAlignment: .end,
            onPressed: _fields.canSubmit.value
                ? () async {
                    if (!_acceptCharter) {
                      _fields.errorAcceptCharter.value = false;
                    } else {
                      await widget.onCreateAccount(
                        email: _fields.identifierController.text,
                        password: _fields.passwordController.text,
                        username: _fields.nameController.text,
                        invitationCode: _fields.inviteCodeController.text,
                        acceptCharter: _acceptCharter,
                      );
                      final AuthSignals authSignals = kGetIt<AuthSignals>();
                      if (authSignals.authError.value != null && context.mounted) {
                        showAuthErrorSheet(
                          context: context,
                          title: 'Impossible de créer le compte',
                          message: authSignals.authError.value!,
                          // Si l'email existe déjà :
                          actionLabel: 'Se connecter à ce compte',
                          onAction: () {
                            authSignals.isLoginTab.value = true; // Bascule sur l'onglet connexion !
                          },
                        );
                      }
                    }
                  }
                : null,
            icon: const Icon(Icons.arrow_forward, size: 18),
            label: const Text('Créer mon compte'),
          ),
        ),
      ],
    );
  }

  String? errorPasswordText() {
    String errorText = '';
    if (!_fields.passwordsMatch.value) {
      return errorText += 'Les mots de passe ne correspondent pas.\n';
    }
    if (!_fields.passwordsLength.value) {
      return errorText += 'Le mot de passe doit avoir 6 caractères minimum.\n';
    }
    return null;
  }
}
