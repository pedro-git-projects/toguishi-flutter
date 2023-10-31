import 'package:flutter/material.dart';
import 'package:toguishi/widgets/forms/pet_shop_form.dart';

class RegisterStoreScreen extends StatelessWidget {
  const RegisterStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta - Lojista'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: PetShopForm(),
          ),
        ),
      ),
    );
  }
}
