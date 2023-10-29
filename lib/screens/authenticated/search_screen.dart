import 'package:flutter/material.dart';
import 'package:toguishi/widgets/menu.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar'),
        actions: const [
          Menu(),
        ],
      ),
      body: const SafeArea(child: Text("Pesquisar")),
    );
  }
}
