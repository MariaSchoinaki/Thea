import 'package:flutter/material.dart';
import 'package:thea/screens/home_page.dart';
import 'package:thea/screens/info_play_page.dart';
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
      routes: {
        '/info_play_page': (context) => InfoPlayPage(),
        '/home_page': (context) => HomePage(),
      },
    );
  }
}
