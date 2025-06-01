import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thea/screens/booking_screen.dart';
import 'package:thea/screens/contact_screen.dart';

import '../../models/globals.dart' as globals;
import '../../models/play.dart';
import '../../screens/chat_screen.dart';
import '../../screens/complaint_screen.dart';
import '../../screens/my_tickets_screen.dart';
import '../../screens/play_details_screen.dart';
import '../chat_bubble.dart';

Widget mapActionToScreen(String action){
  if (action.startsWith('USER_CHOSE_THE_PLAY')){
    final playTitle = action.substring('USER_CHOSE_THE_PLAY-'.length).trim();
    final play = findPlay(playTitle);
    if (play!=null) {
      return BookingScreen(play: play,);
    }
    return ChatbotScreen();
  }
  if (action.startsWith('USER_WANTS_TO_GET_PLAY_INFO-')){
    final playTitle = action.substring('USER_WANTS_TO_GET_PLAY_INFO-'.length).trim();
    final play = findPlay(playTitle);
    if(play!=null) {
      return PlayDetailsScreen(playData: play,);
    }
    return ChatbotScreen();
  }
  const difficultCases = [
    'USER_INPUT_NOT_UNDERSTANDABLE',
    'USER_INPUT_UNRELATED_TO_THEATER',
    'OTHER',
  ];

  if (difficultCases.contains(action)) {
    globals.errorCount++;
  } else {
    globals.errorCount = 0;
  }

  switch(action){
    case 'USER_WANTS_TO_SUBMIT_A_COMPLAINT':
      return ComplaintScreen();
    case 'USER_WANTS_TO_GET_DIRECTIONS':
    case 'USER_WANTS_TO_GET_THEATER_INFO':
    case 'USER_WANTS_TO_CONTACT_A_HUMAN':
      return ContactUsScreen();
    case 'USER_CANCELS_TICKET':
    case 'USER_SEES_PURCHASED_TICKETS':
      return MyTicketsScreen();
    case 'USER_CHOSE_INVALID_PLAY':
    case 'USER_INPUT_NOT_UNDERSTANDABLE':
    case 'USER_INPUT_UNRELATED_TO_THEATER':
    case 'OTHER':
      return ChatbotScreen();
    default:
      return ChatbotScreen();
  }
}

Play? findPlay(String playTitle){
  final _plays = globals.plays;
  for(final play in _plays){
    if (play.title == playTitle){
      return play;
    }
  }
  return null;
}

ChatAction? getAction(BuildContext context, Widget screen){
  if(screen is! ChatbotScreen){
    return ChatAction(
      label: 'Go to Screen',
      onPressed: () {
        print('Redirecting...');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => screen,
          ),
        );
      },
    );
  }
  return null;
}