import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/extensions/context_extension.dart';
import 'package:rose_gold_app_messenger/l10n/app/app_localizations.dart';
import 'package:rose_gold_app_messenger/themes/material/material_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rose Gold App Messenger',
      onGenerateTitle: (BuildContext context) => context.localizations.appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: MaterialTheme.light,
      darkTheme: MaterialTheme.dark,
      // themeMode: .dark, // A supprimer ".system" est déjà configurer par défaut.
      themeMode: .light, //  A supprimer ".system" est déjà configurer par défaut.
      home: Scaffold(body: Center(child: Text(context.localizations.helloWorld))),
    );
  }
}
