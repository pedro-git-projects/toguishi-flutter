import 'package:flutter/material.dart';
import 'package:toguishi/widgets/forms/store/create_advertise.dart';
import 'package:toguishi/widgets/ui/drawer_menu.dart';

class AdvertiseScreen extends StatelessWidget {
  const AdvertiseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerMenu(),
      appBar: AppBar(
        title: const Text('Anunciar'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CreateAdvertiseForm(),
        ),
      ),
    );
  }
}
