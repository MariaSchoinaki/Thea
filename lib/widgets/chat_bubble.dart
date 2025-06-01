import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'loading_dots.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final ChatAction? action;
  final bool isLoading;

  ChatMessage({required this.text, required this.isUser, this.action, this.isLoading = false});
}

class ChatAction {
  final String label;
  final VoidCallback onPressed;

  ChatAction({required this.label, required this.onPressed});
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment:
            message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                message.isUser
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: <Widget>[
              if (!message.isUser)
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage(
                      'assets/images/bot_avatar.png',
                    ), // Small bot avatar
                  ),
                ),
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth:
                        MediaQuery.of(context).size.width *
                        0.7, // Example: 70% of screen width
                  ),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? (message.isUser
                                ? Colors.lightGreen[800]
                                : Colors.grey[600])
                            : (message.isUser
                                ? Colors.lightGreen[300]
                                : Colors.grey[200]),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: message.isLoading ? const LoadingDots() : styledFormattedText(message.text, Theme.of(context)),
                ),
              ),
              if (message.isUser)
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 16,
                    child: Icon(
                      Icons.account_circle,
                      size: 35,
                      color: AppColors.container,
                    ),
                  ),
                ),
            ],
          ),
          if (message.action != null &&
              !message.isUser)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 40.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: theme.textTheme.bodyLarge?.color,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: message.action!.onPressed,
                  child: Text(message.action!.label),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget styledFormattedText(String text, ThemeData theme) {
  final regex = RegExp(r'(\*\*([^*]+)\*\*|\*([^*]+)\*)');
  final spans = <TextSpan>[];
  int lastIndex = 0;

  for (final match in regex.allMatches(text)) {
    if (match.start > lastIndex) {
      spans.add(TextSpan(text: text.substring(lastIndex, match.start)));
    }

    final boldText = match.group(2);
    final italicText = match.group(3);

    if (boldText != null) {
      spans.add(TextSpan(
        text: boldText,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ));
    } else if (italicText != null) {
      spans.add(TextSpan(
        text: italicText,
        style: const TextStyle(fontStyle: FontStyle.italic),
      ));
    }

    lastIndex = match.end;
  }

  if (lastIndex < text.length) {
    spans.add(TextSpan(text: text.substring(lastIndex)));
  }

  return RichText(
    text: TextSpan(
      style: TextStyle(
        color: theme.textTheme.bodyLarge?.color,
        fontSize: 16,
      ),
      children: spans,
    ),
  );
}
