import 'package:flutter/cupertino.dart';

import '../screens/chat_screen.dart';

enum BookingStage {
  initial,
  playDetails,
  dateTimeSelection,
  seatSelection,
  checkout,
  confirmation,
}

void navigate(BuildContext context, BookingStage stage){
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ChatbotScreen(currentStage: stage),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 1.0); // Start from bottom right (relative to screen)
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}