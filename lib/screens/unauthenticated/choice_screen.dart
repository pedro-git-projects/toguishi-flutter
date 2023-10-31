import 'package:flutter/material.dart';
import 'package:toguishi/widgets/forms/choose_user_type.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar conta"),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: ChooseUserType(),
        ),
      ),
    );
  }
}
