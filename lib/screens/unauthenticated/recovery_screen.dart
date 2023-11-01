import 'package:flutter/material.dart';
import 'package:toguishi/widgets/forms/recover_account_form.dart';

class RecoveryScreen extends StatelessWidget {
  const RecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Conta'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: RecoverAccountForm(),
        ),
      ),
    );
  }
}
