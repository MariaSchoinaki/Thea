import 'package:thea/models/play.dart';

import '../data/plays.dart' as plays_db;
import '../util/parser.dart';
import '../widgets/chat_bubble.dart';

List<Play> plays = [];
int errorCount = 0;
const int maxErrors = 3;
List<ChatMessage> chatHistory = [];
String initialMessage =
"""Hello! Welcome to Thea's Theater's AI assistant. I'm here to assist you with the following: 

  • Information about current and upcoming plays
  • Booking or canceling tickets
  • Viewing your purchased tickets
  • Directions and access to the theater
  • Learning more about Thea
  • Contacting a theater employee
  
  How can I help you today?""";

Future<void> loadPlays() async {
  chatHistory.insert(0, ChatMessage(text: initialMessage, isUser: false));

  final String response = plays_db.rawPlayData;
  final data = parseJsonList(response, (map) => Play.fromJson(map));
  plays = data;
}
void clearChatHistoryExceptFirst() {
  if (chatHistory.length > 1) {
    final firstMessage = chatHistory.last;
    chatHistory.clear();
    chatHistory.add(firstMessage);
  }
}
