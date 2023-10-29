import 'package:flutter/material.dart';
import 'package:toguishi/widgets/menu.dart';

class AdvertiseScreen extends StatelessWidget {
  const AdvertiseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anunciar'),
        actions: const [
          Menu(),
        ],
      ),
      body: const SafeArea(child: Text("Anunciar")),
    );
  }
}
