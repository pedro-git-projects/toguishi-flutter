import 'package:flutter/material.dart';
import 'package:toguishi/widgets/ui/drawer_menu.dart';
import 'package:toguishi/widgets/ui/search_box.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerMenu(),
      appBar: AppBar(
        title: const Text('Pesquisar'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SearchBox(),
        ),
      ),
    );
  }
}
