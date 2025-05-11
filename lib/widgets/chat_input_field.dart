import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatInputField extends StatefulWidget {
  final TextEditingController textController;
  final void Function(String) onSubmitted;

  const ChatInputField({
    Key? key,
    required this.textController,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}


class _ChatInputFieldState extends State<ChatInputField> {
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onError: (val) => print('Error: $val'),
        onStatus: (val) => print('Status: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            widget.textController.text = val.recognizedWords;
          }),
        );
      } else {
        print("The user has denied the use of speech recognition.");
      }
    } else {
      _stopListening();
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 2.0,
            color: Colors.grey.withOpacity(0.3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: _isListening ? Icon(Icons.mic_off, color: Colors.red) : Icon(Icons.mic),
            onPressed: _isListening ? _stopListening : _startListening,
          ),
          Expanded(
            child: TextField(
              controller: widget.textController,
              onSubmitted: widget.onSubmitted,
              decoration: const InputDecoration(
                hintText: 'Send a message...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send_rounded),
            onPressed: () {
              if (widget.textController.text.isNotEmpty) {
                widget.onSubmitted(widget.textController.text);
              }
            },
          ),
        ],
      ),
    );
  }
}