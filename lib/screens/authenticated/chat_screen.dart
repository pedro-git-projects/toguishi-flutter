import 'package:flutter/material.dart';
import 'package:toguishi/widgets/ui/drawer_menu.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerMenu(),
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: const SafeArea(child: Text("Chat")),
    );
  }
}
