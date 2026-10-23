import 'package:rose_gold_app_messenger/themes/themes_statics_export.dart';
import 'package:settings_ui/settings_ui.dart';

class AppSettingsTheme {
  static const SettingsThemeData lightSettingsTheme = SettingsThemeData(
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
  );

  static const SettingsThemeData darkSettingsTheme = SettingsThemeData(
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
  );
}
