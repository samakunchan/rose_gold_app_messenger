import 'package:flutter/widgets.dart';
import 'package:rose_gold_app_messenger/l10n/app/app_localizations.dart';
import 'package:rose_gold_app_messenger/l10n/app/app_localizations_en.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this) ?? AppLocalizationsEn();
}
