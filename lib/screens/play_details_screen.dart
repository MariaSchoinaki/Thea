import 'package:flutter/material.dart';
import 'package:thea/models/booking_stage.dart';
import 'package:thea/models/play.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'booking_screen.dart';

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
              children: [
                if (playData.imageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      playData.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                  ),

                const SizedBox(height: 16),

                Text(
                  playData.headline ?? '',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Text(
                  'by ${playData.playwriter ?? ''}',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),

                const SizedBox(height: 16),

                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          playData.description ?? '',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.category),
                        title: const Text("Genre"),
                        subtitle: Text(playData.genre ?? ''),
                      ),
                      ListTile(
                        leading: const Icon(Icons.timer),
                        title: const Text("Runtime"),
                        subtitle: Text(playData.runtime ?? ''),
                      ),
                      ListTile(
                        leading: const Icon(Icons.theater_comedy),
                        title: const Text("Stage"),
                        subtitle: Text(playData.stage ?? ''),
                      ),
                      ListTile(
                        leading: const Icon(Icons.lock),
                        title: const Text("Age Limit"),
                        subtitle: Text(playData.ageLimit ?? ''),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  "Cast",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: playData.cast
                      ?.map((actor) => Chip(label: Text(actor)))
                      .toList() ??
                      [],
                ),

                const SizedBox(height: 16),

                if (playData.additionalInfo != null)
                  Text(
                    playData.additionalInfo!,
                    style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic, color: Colors.grey)
                  ),

                const SizedBox(height: 24),

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
                      'Book Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  navigate(context, BookingStage.playDetails);
                },
                child: const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/bot_avatar.png'),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyNavBar(currentIndex: 0),
    );
  }
}
