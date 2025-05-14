import 'package:flutter/cupertino.dart';

class ChatbotBubbleWrapper extends StatefulWidget {
  final Widget child;
  final bool isVisible;

  const ChatbotBubbleWrapper({Key? key, required this.child, required this.isVisible}) : super(key: key);

  @override
  State<ChatbotBubbleWrapper> createState() => _ChatbotBubbleWrapperState();
}

class _ChatbotBubbleWrapperState extends State<ChatbotBubbleWrapper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start from bottom right (1.0 for right, 0.0 for no vertical shift)
      end: Offset.zero, // End at the original position (bottom left relative to its parent if aligned)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Trigger animation when widget becomes visible
    if (widget.isVisible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant ChatbotBubbleWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _controller.forward();
    } else if (!widget.isVisible && oldWidget.isVisible) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}