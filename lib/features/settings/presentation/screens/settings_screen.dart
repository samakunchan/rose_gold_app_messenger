import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/languages_signals.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/theme_mode_signals.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/themes/themes_statics_export.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SettingsScreen extends StatelessWidget {
  const new({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthSignals authSignals = kGetIt<AuthSignals>();
    final ThemeModeSignals themeModeSignals = kGetIt<ThemeModeSignals>();
    final LanguagesSignals languagesSignals = kGetIt<LanguagesSignals>();

    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: SettingsList(
        lightTheme: const SettingsThemeData(
          settingsListBackground: kLightBaseCanvasColor,
          settingsSectionBackground: kLightSurfaceContainerLowestColor,
          listPaneBackground: kLightSurfaceContainerLowColor,
          dividerColor: kHairlineDividerColor,
          leadingIconsColor: kLightPrimaryColor,
          titleTextColor: kLightPrimaryColor,
          settingsTileTextColor: kLightOnSurfaceColor,
          tileDescriptionTextColor: kLightOnSurfaceVariantColor,
          trailingTextColor: kTaupeMutedTextColor,
          tileHighlightColor: kBlushTintLightColor,
          inactiveTitleColor: kLightOutlineColor,
          inactiveSubtitleColor: kLightOutlineVariantColor,
          selectedTileColor: kLightPrimaryFixedColor,
          selectedTileTextColor: kLightOnPrimaryContainerColor,
          selectedTileIconColor: kLightPrimaryColor,
        ),
        darkTheme: const SettingsThemeData(
          settingsListBackground: kDarkBackgroundColor,
          settingsSectionBackground: kDarkSurfaceContainerColor,
          listPaneBackground: kDarkSurfaceContainerLowColor,
          dividerColor: kDarkHairlineDividerColor,
          leadingIconsColor: kDarkPrimaryColor,
          titleTextColor: kDarkPrimaryColor,
          settingsTileTextColor: kDarkOnSurfaceColor,
          tileDescriptionTextColor: kDarkOnSurfaceVariantColor,
          trailingTextColor: kDarkTaupeMutedTextColor,
          tileHighlightColor: kDarkSurfaceContainerHighColor,
          inactiveTitleColor: kDarkOutlineColor,
          inactiveSubtitleColor: kDarkOutlineVariantColor,
          selectedTileColor: kDarkPrimaryContainerColor,
          selectedTileTextColor: kDarkOnPrimaryContainerColor,
          selectedTileIconColor: kDarkPrimaryColor,
        ),
        sections: <AbstractSettingsSection>[
          SettingsSection(
            title: const Text('Compte & Sécurité'),
            tiles: <AbstractSettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.person_outline),
                title: const Text('Modifier le profil'),
                onPressed: (_) {},
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.lock_outline),
                title: const Text('Changer le mot de passe'),
                onPressed: (_) {},
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.delete_forever_outlined),
                title: const Text('Supprimer mon compte'),
                description: const Text('Suppression définitive du compte et des données'),
                onPressed: (_) async {
                  await authSignals.deleteAppMessengerAccount();
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),

          /// ICI
          SettingsSection(
            title: const Text('Général'),
            tiles: <AbstractSettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.brightness_6_outlined),
                title: const Text('Apparence'),
                value: SignalBuilder(builder: (_) => Text(themeModeSignals.themeModeLabel.value)),
                onPressed: (BuildContext context) => _openAppearanceBottomSheet(context, themeModeSignals),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: const Text('Langue'),
                value: SignalBuilder(builder: (_) => Text(languagesSignals.languageLabel.value)),
                onPressed: (BuildContext context) => _openLanguageBottomSheet(context, languagesSignals),
              ),
              SettingsTile.switchTile(
                leading: const Icon(Icons.notifications_outlined),
                title: const Text('Notifications'),
                initialValue: true,
                onToggle: (bool value) {},
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Confidentialité & RGPD'),
            tiles: <AbstractSettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.block_outlined),
                title: const Text('Utilisateurs bloqués'),
                onPressed: (_) {},
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.download_outlined),
                title: const Text('Exporter mes données'),
                description: const Text('Télécharger une copie de vos données personnelles'),
                onPressed: (_) {},
              ),
              SettingsTile.switchTile(
                leading: const Icon(Icons.analytics_outlined),
                title: const Text('Partage des données de diagnostic'),
                description: const Text('Aider à améliorer l’application'),
                initialValue: true,
                onToggle: (bool value) {},
              ),
              SettingsTile(
                leading: const Icon(Icons.cleaning_services_outlined),
                title: const Text('Vider le cache local'),
                description: const Text('Effacer les messages et médias stockés sur cet appareil'),
                onPressed: (_) {},
              ),
            ],
          ),
          SettingsSection(
            title: const Text('À propos & Légal'),
            tiles: <AbstractSettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.bug_report_outlined),
                title: const Text('Signaler un bug / Envoyer un retour'),
                onPressed: (_) {},
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: const Text('Politique de confidentialité'),
                onPressed: (_) {},
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.description_outlined),
                title: const Text('Conditions Générales d’Utilisation'),
                onPressed: (_) {},
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.code_outlined),
                title: const Text('Licences open-source'),
                onPressed: (_) => showLicensePage(context: context),
              ),
              SettingsTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Version'),
                value: const Text('0.6.0 (1)'),
              ),
            ],
          ),
          CustomSettingsSection(
            child: Padding(
              padding: .symmetric(horizontal: AppSpacing.spaceLg.value, vertical: AppSpacing.spaceMd.value),
              child: SizedBox(
                width: .infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text('Se déconnecter'),
                  onPressed: () async {
                    await authSignals.signOut();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openAppearanceBottomSheet(BuildContext context, ThemeModeSignals signals) async {
    final ThemeData theme = Theme.of(context);
    final ThemeMode? selectedMode = await showModalBottomSheet<ThemeMode>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Padding(
            padding: .only(
              left: AppSpacing.spaceMd.value,
              right: AppSpacing.spaceMd.value,
              bottom: AppSpacing.spaceMd.value,
            ),
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              spacing: AppSpacing.spaceXs.value,
              children: <Widget>[
                Padding(
                  padding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceXs.value),
                  child: Text('Apparence', style: theme.textTheme.titleMedium),
                ),
                ListTile(
                  leading: const Icon(Icons.brightness_auto_outlined),
                  title: const Text('Système'),
                  trailing: signals.themeMode.value == .system ? Icon(Icons.check, color: theme.colorScheme.primary) : null,
                  onTap: () => Navigator.of(sheetContext).pop<ThemeMode>(.system),
                ),
                ListTile(
                  leading: const Icon(Icons.light_mode_outlined),
                  title: const Text('Clair'),
                  trailing: signals.themeMode.value == .light ? Icon(Icons.check, color: theme.colorScheme.primary) : null,
                  onTap: () => Navigator.of(sheetContext).pop<ThemeMode>(.light),
                ),
                ListTile(
                  leading: const Icon(Icons.dark_mode_outlined),
                  title: const Text('Sombre'),
                  trailing: signals.themeMode.value == .dark ? Icon(Icons.check, color: theme.colorScheme.primary) : null,
                  onTap: () => Navigator.of(sheetContext).pop<ThemeMode>(.dark),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selectedMode != null && selectedMode != signals.themeMode.value) {
      await signals.changeThemeMode(selectedMode: selectedMode);
    }
  }

  Future<void> _openLanguageBottomSheet(BuildContext context, LanguagesSignals signals) async {
    final ThemeData theme = Theme.of(context);
    final String? selectedLanguage = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Padding(
            padding: .only(
              left: AppSpacing.spaceMd.value,
              right: AppSpacing.spaceMd.value,
              bottom: AppSpacing.spaceMd.value,
            ),
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              spacing: AppSpacing.spaceXs.value,
              children: <Widget>[
                Padding(
                  padding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceXs.value),
                  child: Text('Sélection des langues', style: theme.textTheme.titleMedium),
                ),
                ListTile(
                  title: const Text('Français'),
                  trailing: signals.code.value == 'fr' ? Icon(Icons.check, color: theme.colorScheme.primary) : null,
                  onTap: () => Navigator.of(sheetContext).pop<String>('fr'),
                ),
                ListTile(
                  title: const Text('English'),
                  trailing: signals.code.value == 'en' ? Icon(Icons.check, color: theme.colorScheme.primary) : null,
                  onTap: () => Navigator.of(sheetContext).pop<String>('en'),
                ),
                ListTile(
                  title: const Text('Español'),
                  trailing: signals.code.value == 'es' ? Icon(Icons.check, color: theme.colorScheme.primary) : null,
                  onTap: () => Navigator.of(sheetContext).pop<String>('es'),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selectedLanguage != null && selectedLanguage != signals.code.value) {
      await signals.changeLangues(languageCode: selectedLanguage);
    }
  }
}
