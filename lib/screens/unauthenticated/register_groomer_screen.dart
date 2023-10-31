import 'package:flutter/material.dart';
import 'package:toguishi/widgets/forms/groomer_form.dart';

class RegisterGroomerScreen extends StatelessWidget {
  const RegisterGroomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta - Tosador'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: GroomerForm(),
          ),
        ),
      ),
    );
  }
}
