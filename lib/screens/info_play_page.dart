import 'package:flutter/material.dart';
import 'package:thea/screens/play_details_screen.dart';
import '../models/play.dart';
import '../data/plays.dart' as plays_db;
import '../util/parser.dart';
import '../theme/app_theme.dart';
import 'booking_screen.dart';
import 'my_tickets_screen.dart';

class InfoPlayPage extends StatefulWidget {
  @override
  State<InfoPlayPage> createState() => _InfoPlayPageState();
}

class _InfoPlayPageState extends State<InfoPlayPage> {
  List<Play> _plays = [];

  @override
  void initState() {
    super.initState();
    loadPlays();
  }

  Future<void> loadPlays() async {
    final String response = plays_db.rawPlayData;
    final data = parseJsonList(response, (map) => Play.fromJson(map));
    setState(() {
      _plays = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Thea", style: theme.appBarTheme.titleTextStyle),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
      ),
      body: _plays.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _plays.length,
        itemBuilder: (context, index) {
          final play = _plays[index];
          return Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.container,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(play.imageUrl),
                ),
                SizedBox(height: 12),
                Text(
                  play.playwriter,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayDetailsScreen(playData: _plays[index]),
                          ),
                        );
                      },
                      child: Text("More Info",
                          style: TextStyle(color: AppColors.lightText)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.coral,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingScreen(play: _plays[index]),
                          ),
                        );
                      },
                      child: Text("Book",
                          style: TextStyle(color: AppColors.lightText)),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
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
