import 'package:flutter/material.dart';
import 'live_chat_list.dart';
import 'live_chat_input.dart';

class LiveChatSection extends StatefulWidget {
  const LiveChatSection({super.key});

  @override
  State<LiveChatSection> createState() => _LiveChatSectionState();
}

class _LiveChatSectionState extends State<LiveChatSection> {
  final List<String> _chatMessages = [
    'Wow, the video stream looks incredibly crisp! 🔥',
    'Best cyberpunk live stream in Flutter! 🦾',
    'Greetings from Cairo! 🇪🇬',
    'Is this using WebSockets? So fast!',
  ];

  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LiveChatList(
            chatMessages: _chatMessages,
          ),
        ),
        LiveChatInput(
          controller: _commentController,
          onSendMessage: () {
            if (_commentController.text.isNotEmpty) {
              setState(() {
                _chatMessages.add(_commentController.text);
                _commentController.clear();
              });
            }
          },
        ),
      ],
    );
  }
}
