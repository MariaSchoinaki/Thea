import 'package:flutter/material.dart';
import 'package:thea/models/booking_stage.dart';
import 'package:thea/models/play.dart';

import '../theme/app_theme.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'booking_screen.dart';
import 'my_tickets_screen.dart';

class PlayDetailsScreen extends StatelessWidget {
  final Play playData;

  const PlayDetailsScreen({Key? key, required this.playData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
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
                  'Hall: ${playData.stage ?? ''}',
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
                      backgroundColor: isDark ? AppColorsDark.coral : AppColors.coral,
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
                      navigate(context, BookingStage.playDetails);
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
        bottomNavigationBar: MyNavBar(currentIndex: 0),
    );
  }
}