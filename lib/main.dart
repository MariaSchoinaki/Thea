import 'package:flutter/material.dart';
import 'screens/start_page.dart';

void main() {
  runApp(const TheaApp());
}

class TheaApp extends StatelessWidget {
  const TheaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }
}
