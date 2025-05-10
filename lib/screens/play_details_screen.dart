import 'package:flutter/material.dart';
import 'package:thea/models/play.dart';

import '../theme/app_theme.dart';
import 'booking_screen.dart';
import 'my_tickets_screen.dart';

class PlayDetailsScreen extends StatelessWidget {
  final Play playData;

  const PlayDetailsScreen({Key? key, required this.playData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(playData.title ?? 'Play Details', style: theme.appBarTheme.titleTextStyle),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Image
                if (playData.imageUrl != null)
                  Image.asset(
                    playData.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                else
                  const SizedBox.shrink(), // Or a placeholder image

                const SizedBox(height: 16.0),

                // Headline
                Text(
                  playData.genre ?? '',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                const SizedBox(height: 8.0),

                // Playwriter
                Text(
                  'By ${playData.playwriter ?? ''}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 16.0),

                // Description
                Text(
                  playData.description ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 24.0),

                // Runtime
                Text(
                  'Runtime: ${playData.runtime ?? ''}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 8.0),

                // Hall
                Text(
                  'Hall: ${playData.hall ?? ''}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),

                const SizedBox(height: 24.0),

                // Book Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingScreen(play: playData),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.coral, // Match the button color
                    ),
                    child: const Text(
                      'Book',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 80.0), // Add some bottom padding to avoid overlap
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      //TODO: implement chatbot screen
                      print('Chatbot avatar tapped');
                    },
                    child: const CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage('assets/images/bot_avatar.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppColors.container,
        unselectedItemColor: AppColors.darkText,
        backgroundColor: AppColors.background,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home_page');
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyTicketsScreen(),
                ),
              );
              break;
            case 2:
            //Navigator.pushNamed(context, '/settings');
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
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}