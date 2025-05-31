import 'package:flutter/material.dart';
import 'package:thea/screens/complaint_screen.dart';
import 'package:thea/screens/faq_screen.dart';

import '../models/booking_stage.dart';
import '../models/globals.dart' as globals;
import '../models/play.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'contact_screen.dart';
import 'my_tickets_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var plays = globals.plays;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Image.asset(
                'assets/images/thea_name.png',
                height: 120,
              ),
              const SizedBox(height: 30),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.2,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildMenuButton(Image.asset('assets/icons/masks.png', width: 50, height: 50,),
                                  'Book a ticket',
                                    onTap: () {
                                      Navigator.pushNamed(context, '/info_play_page');
                                    },),
                  _buildMenuButton(Image.asset('assets/icons/tickets.png',width: 50,height: 50,),
                                    'See your tickets',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyTicketsScreen(),
                                        ),
                                      );
                                    },),
                  _buildMenuButton(Image.asset('assets/icons/complaints.png',width: 50,height: 50,),
                                    'Make a complaint',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ComplaintScreen(),
                                        ),
                                      );
                                    },),
                  _buildMenuButton(Image.asset('assets/icons/faq.png', width: 50, height: 50,),
                                    'Frequently asked questions',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FAQScreen(),
                                        ),
                                      );
                                    },),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactUsScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.headset_mic),
                label: const Text(
                  'Call a representative',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.darkText,
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: Text('Hi, how can I help you?', style: TextStyle(color: Colors.black )),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        navigate(context, BookingStage.initial);
                      },
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage('assets/images/bot_avatar.png'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
        bottomNavigationBar: MyNavBar(currentIndex: 0)
    );
  }

  Widget _buildMenuButton(Widget icon, String label, {VoidCallback? onTap}) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.brownDark),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(height: 8),
              Text(
                label,
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
