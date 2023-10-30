import 'package:flutter/material.dart';
import 'package:toguishi/widgets/ui/menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toguishi'),
        actions: const [
          Menu(),
        ],
      ),
      body: const SafeArea(child: Text("Home")),
    );
  }
}
