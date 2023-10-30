import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toguishi/state/auth_provider.dart';
import 'package:toguishi/state/config_provider.dart';
import 'package:toguishi/state/storage_service.dart';

import 'package:http/http.dart' as http;

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: (RegisterForm()),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _tipo = "TOSADOR";
  bool _possuiTesoura = false;
  bool _possuiLamina = false;
  bool _possuiMaquina = false;

  final _nomeController = TextEditingController();
  final _cpfCnpjController = TextEditingController();
  final _cepController = TextEditingController();

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

  Future<void> _registerUser() async {
    if (_formKey.currentState?.validate() ?? true) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final nome = _nomeController.text;
      final cpfOuCnpj = _cpfCnpjController.text;
      final cep = _cepController.text;

      final tipo = _tipo;
      final possuiTesoura = _possuiTesoura;
      final possuiLamina = _possuiLamina;
      final possuiMaquina = _possuiMaquina;

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
        "possuiTesoura": possuiTesoura,
        "possuiLamina": possuiLamina,
        "possuiMaquina": possuiMaquina,
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _tipo,
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem(
                  value: 'TOSADOR',
                  child: Text('Tosador'),
                ),
                DropdownMenuItem(
                  value: 'LOJISTA',
                  child: Text('Lojista'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                    _tipo = value!;
                });
              },
            ),
            TextFormField(
              controller: _emailController,
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
              controller: _passwordController,
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
              controller: _nomeController,
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
              controller: _cpfCnpjController,
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
              controller: _cepController,
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
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Checkbox(
                  value: _possuiTesoura,
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        _possuiTesoura = value;
                      }
                    });
                  },
                ),
                const Text("Possui tesoura"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _possuiLamina,
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        _possuiLamina = value;
                      }
                    });
                  },
                ),
                const Text("Possui lâmina"),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _possuiMaquina,
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        _possuiMaquina = value;
                      }
                    });
                  },
                ),
                const Text("Possui máquina"),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _registerUser,
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
