import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thea/screens/home_page.dart';
import 'package:thea/screens/info_play_page.dart';
import 'package:thea/screens/preferences_screen.dart';
import 'package:thea/screens/tutorial_screen.dart';
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

class TheaApp extends StatefulWidget{
  const TheaApp({super.key});

  @override
  State<TheaApp> createState() => _TheaAppState();
}

class _TheaAppState extends State<TheaApp> {
  bool _isLoading = true;
  bool _showTutorial = false;

  @override
  void initState() {
    super.initState();
    _checkTutorialStatus();
  }

  void _checkTutorialStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final hasCompletedTutorial = prefs.getBool('tutorial_completed') ?? false;
    setState(() {
      _showTutorial = !hasCompletedTutorial;
      _isLoading = false;
    });
  }

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
      home: _isLoading
          ? Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: const Center(child: CircularProgressIndicator()),
      )
          : _showTutorial
          ? const TutorialScreen()
          : const StartScreen(),
      routes: {
        '/info_play_page': (context) => InfoPlayPage(),
        '/home_page': (context) => HomePage(),
        '/start': (context) => const StartScreen(),
        '/tutorial': (context) => const TutorialScreen(),
      },
    );
  }
}
