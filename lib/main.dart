import 'package:flutter/material.dart';
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
      debugShowCheckedModeBanner: false,
      theme: MaterialTheme.light,
      darkTheme: MaterialTheme.dark,
      // themeMode: .dark, // ".system" est déjà configurer par défaut.
      themeMode: .light,
      home: const Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}
