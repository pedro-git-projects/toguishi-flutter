import 'package:flutter/material.dart';
import 'package:toguishi/widgets/ui/drawer_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerMenu(),
      appBar: AppBar(
        title: const Text('Toguishi'),
      ),
      body: const SafeArea(child: Text("Home")),
    );
  }
}
