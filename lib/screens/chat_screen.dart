import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thea/theme/app_theme.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../models/booking_stage.dart';
import '../models/globals.dart' as globals;
import '../widgets/actions/actions.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_field.dart';
import 'contact_screen.dart';

class ChatbotScreen extends StatefulWidget {
  final BookingStage? currentStage;
  const ChatbotScreen({Key? key, this.currentStage}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleSubmitted(String text) async {
    _textController.clear();

    setState(() {
      globals.chatHistory.insert(0, ChatMessage(text: text, isUser: true));
    });

    final loadingMsg = ChatMessage(text: '', isUser: false, isLoading: true);
    setState(() {
      globals.chatHistory.insert(0, loadingMsg);
    });

    Map<String, dynamic>? botResponse = await _getLLMResponse(text);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      globals.chatHistory.remove(loadingMsg);

      if (botResponse != null && botResponse.isNotEmpty) {
        globals.chatHistory.insert(0, ChatMessage(text: botResponse['message'], isUser: false,
            action:  getAction(context, mapActionToScreen(botResponse['code']))
        ));
      } else {
        globals.chatHistory.insert(0, ChatMessage(
          text: 'Sorry, I couldn\'t generate a response.',
          isUser: false,
        ));
      }
    });
  }

  Future<Map<String,dynamic>?> _getLLMResponse(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse('https://ip/send_message'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': prompt}),
      );

      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
        final responseData = data['response'];
        String responseText;

        if (responseData is Map && responseData.containsKey('message')) {
          responseText = responseData['message'] as String;
        } else if (responseData is String) {
          responseText = responseData;
        } else {
          throw Exception('Invalid response format');
        }
        String responseCode = data['code'];
        print("RESPONS TEXT: $responseText");
        print("RESPONSE CODE: $responseCode");
        final responsePattern = RegExp(r'Human:\s*(.*?)(?:<\|eot_id\|>|$)', dotAll: true);
        final match = responsePattern .firstMatch(responseText);
        if (match != null) {
          String message = match.group(1) ?? '';
          message = message.trim();
          return {
            'message': message,
            'code': responseCode
          };
        }
      } else {
        print('Server error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching LLM response: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title:  Text('Chatbot', style: TextStyle(color: isDark? Colors.grey[300] : Colors.black87)),
        backgroundColor: isDark? AppColorsDark.background : AppColors.background,
        iconTheme:  IconThemeData(color: isDark? Colors.grey[300] : Colors.black87),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true, // To show the latest messages at the bottom
              padding: const EdgeInsets.all(8.0),
              itemCount: globals.chatHistory.length,
              itemBuilder: (context, index) => ChatBubble(message: globals.chatHistory[index]),
            ),
          ),
          if (globals.errorCount >= 3) ...[
            ElevatedButton(
              onPressed: clearHistory,
              child: Text('Clear History'),
            ),
            ElevatedButton(
              onPressed: contactSupport,
              child: Text('Contact Support'),
            ),
          ],
          const Divider(height: 1.0),
          ChatInputField(
            textController: _textController,
            onSubmitted: _handleSubmitted,
          ),
        ],
      ),
    );
  }

  void clearHistory() {
    setState(() {
      globals.errorCount = 0;
      globals.clearChatHistoryExceptFirst();
    });
  }

  void contactSupport() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ContactUsScreen()));
  }

}
