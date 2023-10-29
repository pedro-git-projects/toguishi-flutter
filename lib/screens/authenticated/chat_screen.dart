import 'package:flutter/material.dart';
import 'package:toguishi/widgets/menu.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: const [
          Menu(),
        ],
      ),
      body: const SafeArea(child: Text("Chat")),
    );
  }
}
