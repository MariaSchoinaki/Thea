import 'package:flutter/material.dart';
import 'screens/start_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const TheaApp());
}

class TheaApp extends StatelessWidget {
  const TheaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const StartScreen(),
    );
  }
}
