import 'package:flutter/material.dart';
import 'package:thea/theme/app_theme.dart';

import '../models/booking_stage.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_field.dart';

class ChatbotScreen extends StatefulWidget {
  final BookingStage? currentStage;
  const ChatbotScreen({Key? key, this.currentStage}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messages.insert(0, ChatMessage(text: 'Hello, I am the assistant and I am here to help you.', isUser: false));
  }

  Future<void> _handleSubmitted(String text) async {
    _textController.clear();
    setState(() async {
      _messages.insert(0, ChatMessage(text: text, isUser: true));


      // Call your LLM integration function
      String? botResponse = await _getLLMResponse(text);


      // Simulate bot response after a short delay
      Future.delayed(const Duration(milliseconds: 500), () {
        if (botResponse != null && botResponse.isNotEmpty) {
          setState(() {
            _messages.insert(0, ChatMessage(text: botResponse, isUser: false));
          });
        } else {
          // Handle the case where the LLM doesn't provide a response or an error occurs
          setState(() {
            _messages.insert(0, ChatMessage(text: 'Sorry, I couldn\'t generate a response.', isUser: false));
          });
        }
      });
    });
  }

  // Placeholder for the LLM integration logic
  Future<String?> _getLLMResponse(String prompt) async {
    return _generateBotResponse(prompt);
  }

  String _generateBotResponse(String userMessage) {
    // Simple logic for generating a bot response
    if (userMessage.toLowerCase().contains('complaint')) {
      return 'I understand you have a complaint. Could you please describe it?';
    } else if (userMessage.toLowerCase().contains('ticket')) {
      return 'Are you having trouble with your ticket?';
    } else {
      return 'Thank you for your message.';
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
              itemCount: _messages.length,
              itemBuilder: (context, index) => ChatBubble(message: _messages[index]),
            ),
          ),
          const Divider(height: 1.0),
          ChatInputField(
            textController: _textController,
            onSubmitted: _handleSubmitted,
          ),
        ],
      ),
    );
  }
}
