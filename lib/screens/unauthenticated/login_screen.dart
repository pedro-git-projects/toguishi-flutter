import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:toguishi/main.dart';
import 'package:toguishi/services/storage_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

  Future<void> _loginUser() async {
    if (_formKey.currentState?.validate() ?? true) {
      final email = emailController.text;
      final password = passwordController.text;

      final config = Provider.of<ConfigProvider>(context, listen: false);
      final ip = config.ip;

      final storageService =
          Provider.of<StorageService>(context, listen: false);

      final authState = Provider.of<AuthState>(context, listen: false);

      final requestBody = jsonEncode({
        "email": email,
        "senha": password,
      });

      final response = await http.post(
        Uri.parse('http://$ip:3000/auth/signin/usuario'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );
      print(requestBody);

      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)['access_token'];
        storageService.write('token', token);
        authState.checkAuthentication();
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
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'O email não pode estar vazio';
              }
              return null;
            },
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Senha'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Por favor insira sua senha';
              }
              return null;
            },
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: _loginUser,
            child: const Text('Login'),
          )
        ],
      ),
    );
  }
}
