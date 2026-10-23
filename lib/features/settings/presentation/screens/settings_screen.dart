import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/widgets/sections/about_settings_section.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/widgets/sections/account_settings_section.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/widgets/sections/general_settings_section.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/widgets/sections/logout_settings_section.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/widgets/sections/privacy_settings_section.dart';
import 'package:rose_gold_app_messenger/themes/app_settings_theme.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: const SettingsList(
        lightTheme: AppSettingsTheme.lightSettingsTheme,
        darkTheme: AppSettingsTheme.darkSettingsTheme,
        sections: <AbstractSettingsSection>[
          AccountSettingsSection(),
          GeneralSettingsSection(),
          PrivacySettingsSection(),
          AboutSettingsSection(),
          LogoutSettingsSection(),
        ],
      ),
    );
  }
}
