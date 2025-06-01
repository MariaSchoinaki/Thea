import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thea/theme/app_theme.dart';

class TutorialScreen extends StatefulWidget{
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen>{
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<TutorialPage> _pages = [
    TutorialPage(
      image: 'assets/icons/masks.png',
      title: 'Book Your Favorite Theatre Plays',
      description: 'Browse through a wide selection of plays, musicals and performances. Find showtimes and book tickets instantly.',
      color: AppColors.blue
    ),
    TutorialPage(
        image: 'assets/icons/bot_avatar.png',
        title: 'Meet Thea - Your Virtual Assistant',
        description: 'Get instant help with bookings, seat selection, and venue information through our intelligent chatbot.',
        color: Colors.blue
    ),
    TutorialPage(
        image: 'assets/icons/tickets.png',
        title: 'Manage Your Tickets',
        description: 'View your booking history, download tickets, and cancel the tickets you want.',
        color: AppColors.blue
    ),
    TutorialPage(
        image: 'assets/icons/accessibility.png',
        title: 'Preferences - Change Your App Style',
        description: 'You can now change the app style based to your preferences. Modify the texts size, change the app theme or even change your name in the app.',
        color: AppColors.blue
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeTutorial();
    }
  }

  void _skipTutorial() {
    _completeTutorial();
  }

  void _completeTutorial() async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tutorial_completed', true);

    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/start');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 60),
                  Row(
                    children: List.generate(
                      _pages.length,
                          (index) =>
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: _currentPage == index ? 24 : 8,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? _pages[_currentPage].color
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                    ),
                  ),
                  // Skip button
                  TextButton(
                    onPressed: _skipTutorial,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: _pages[index].color.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Image.asset(
                              _pages[index].image,
                              width: 72,
                              height: 72,
                              color: _pages[index].image == 'assets/icons/bot_avatar.png'
                                ? null
                                : _pages[index].color,
                            ),
                          ),
                        ),

                        const SizedBox(height: 48),

                        Text(
                          _pages[index].title,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 24),

                        Text(
                          _pages[index].description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: _currentPage > 0
                        ? TextButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text(
                        'Previous',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                        : null,
                  ),

                  // Next/Get Started button
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _pages[_currentPage].color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      _currentPage == _pages.length - 1
                          ? 'Get Started'
                          : 'Next',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class TutorialPage {
  final String image;
  final String title;
  final String description;
  final Color color;

  TutorialPage({
    required this.image,
    required this.title,
    required this.description,
    required this.color,
  });
}
