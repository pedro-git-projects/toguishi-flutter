import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toguishi/state/auth_provider.dart';
import 'package:toguishi/state/config_provider.dart';
import 'package:toguishi/state/storage_service.dart';

import 'package:http/http.dart' as http;

class PetShopForm extends StatefulWidget {
  const PetShopForm({super.key});

  @override
  State<PetShopForm> createState() => _PetShopFormState();
}

class _PetShopFormState extends State<PetShopForm> {
  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nomeController = TextEditingController();
  final cpfCnpjController = TextEditingController();
  final cepController = TextEditingController();

  final String _tipo = "LOJISTA";

  Future<void> _registerStore() async {
    if (_formKey.currentState?.validate() ?? true) {
      final email = emailController.text;
      final password = passwordController.text;
      final nome = nomeController.text;
      final cpfOuCnpj = cpfCnpjController.text;
      final cep = cepController.text;

      final tipo = _tipo;

      final config = Provider.of<ConfigProvider>(context, listen: false);
      final ip = config.ip;

      final storageService =
          Provider.of<StorageService>(context, listen: false);

      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final requestBody = jsonEncode({
        "email": email,
        "password": password,
        "nome": nome,
        "cpfOuCnpj": cpfOuCnpj,
        "cep": cep,
        "tipo": tipo,
      });

      print(requestBody);

      final response = await http.post(
        Uri.parse('http://$ip:3000/auth/signup'),
        headers: {'Cotent-Type': 'application/json'},
        body: requestBody,
      );

      if (response.statusCode == 201) {
        final token = jsonDecode(response.body)['access_token'];
        storageService.write('token', token);
        authProvider.checkAuthentication();
        print(token);
      } else {
        final errorMessage = jsonDecode(response.body)['message'];
        _showErrorDialog(errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor um email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Senha",
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor insira sua senha';
                }
                return null;
              },
            ),
            TextFormField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: "Nome",
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor insira seu nome';
                }
                return null;
              },
            ),
            TextFormField(
              controller: cpfCnpjController,
              decoration: const InputDecoration(
                labelText: "CPF ou CNPJ",
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor insira seu CPF ou CNPJ';
                }
                return null;
              },
            ),
            TextFormField(
              controller: cepController,
              decoration: const InputDecoration(
                labelText: "CEP",
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Por favor insira seu CEP';
                }
                return null;
              },
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _registerStore,
                  child: const Text("Cadastrar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
