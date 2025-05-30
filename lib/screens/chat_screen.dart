import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
    });

    String? botResponse = await _getLLMResponse(text);

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      if (botResponse != null && botResponse.isNotEmpty) {
        _messages.insert(0, ChatMessage(text: botResponse, isUser: false));
      } else {
        _messages.insert(0, ChatMessage(
          text: 'Sorry, I couldn\'t generate a response.',
          isUser: false,
        ));
      }
    });
  }

  // Placeholder for the LLM integration logic
  Future<String?> _getLLMResponse(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse('https://ip/send_message'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': prompt}),
      );

      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
        return data['response'];
      } else {
        print('Server error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching LLM response: $e');
      return null;
    }
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
