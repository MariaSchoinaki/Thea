import 'package:flutter/material.dart';
import 'package:thea/screens/home_page.dart';
import 'package:thea/screens/info_play_page.dart';
import 'package:thea/screens/preferences_screen.dart';
import 'screens/start_page.dart';
import 'theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PreferencesNotifier()),
      ChangeNotifierProvider(create: (_) => UserNotifier()),
    ],
    child: const TheaApp(),
  ),);
}

class TheaApp extends StatelessWidget {
  const TheaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final preferences = context.watch<PreferencesNotifier>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: preferences.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(preferences.textScale)),
          child: child!,
        );
      },
      home: const StartScreen(),
      routes: {
        '/info_play_page': (context) => InfoPlayPage(),
        '/home_page': (context) => HomePage(),
      },
    );
  }
}
