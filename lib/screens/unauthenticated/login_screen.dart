import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:toguishi/main.dart';

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
  final storage = FlutterSecureStorage();

  Future<void> _loginUser() async {
    if (_formKey.currentState?.validate() ?? true) {
      final email = emailController.text;
      final password = passwordController.text;

      final config = Provider.of<ConfigProvider>(context, listen: false);
      final ip = config.ip;

      final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
          GlobalKey<ScaffoldMessengerState>();

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
        await storage.write(key: 'token', value: token);
        print(token);
      } else {
        print("TODO: FIX SNACKBAR");
        const errorMessage = 'Falha no login';
        scaffoldMessengerKey.currentState?.showSnackBar(
          const SnackBar(
            content: Text(errorMessage),
          ),
        );
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
