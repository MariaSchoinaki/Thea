import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/my_tickets_screen.dart';
import '../../screens/home_page.dart';
import '../../screens/preferences_screen.dart';

class MyNavBar extends StatelessWidget{
  final int currentIndex;
  const MyNavBar({super.key, required this.currentIndex});


  @override
  Widget build(BuildContext context) {
    final preferences = context.watch<PreferencesNotifier>();
    return BottomNavigationBar(
      currentIndex: currentIndex,
      iconSize: 24 * preferences.textScale,
      selectedFontSize: 14 * preferences.textScale,
      unselectedFontSize: 12 * preferences.textScale,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
                  (Route<dynamic> route) => false,
            );
            break;
          case 1:
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MyTicketsScreen()),
                  (Route<dynamic> route) => false,
            );
            break;
          case 2:
          // Navigator.pushNamed(context, '/settings');
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => PreferencesScreen(),
              ),
                  (Route<dynamic> route) => false,
            );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.confirmation_number),
          label: 'My tickets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_accessibility),
          label: 'Preferences',
        ),
      ],
    );
  }


}