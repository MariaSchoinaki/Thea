import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'my_tickets_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                                      //TODO: Implement complaint screen
                                    },),
                  _buildMenuButton(Image.asset('assets/icons/faq.png', width: 50, height: 50,),
                                    'Frequently asked questions',
                                    onTap: () {
                                      //TODO: Implement FAQ screen
                                    },),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  //TODO: Implement call to representative
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brownLight,
                  foregroundColor: AppColors.darkText,
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
                      child: const Text('Hi, how can I help you?'),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        //TODO: implement chatbot screen
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppColors.container,
        unselectedItemColor: AppColors.darkText,
        backgroundColor: AppColors.background,
        onTap: (index) {
          switch (index) {
            case 0:
              //Navigator.pushNamed(context, '/home');
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
            icon: Icon(Icons.settings),
            label: 'Preferences',
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(Widget icon, String label, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.container,
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
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.darkText,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
