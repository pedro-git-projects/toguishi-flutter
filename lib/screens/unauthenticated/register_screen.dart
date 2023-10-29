import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: (RegisterForm()),
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _tipo = "Tosador";
  bool _possuiTesoura = false;
  bool _possuiLamina = false;
  bool _possuiMaquina = false;

  final _nomeController = TextEditingController();
  final _cpfCnpjController = TextEditingController();
  final _cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField(
            value: _tipo,
            items: const [
              DropdownMenuItem(
                value: "Tosador",
                child: Text("Tosador"),
              ),
              DropdownMenuItem(
                value: "Lojista",
                child: Text("Lojista"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  _tipo = value;
                }
              });
            },
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: "Email",
            ),
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: "Senha",
            ),
            obscureText: true,
          ),
          TextFormField(
            controller: _nomeController,
            decoration: const InputDecoration(
              labelText: "Nome",
            ),
          ),
          TextFormField(
            controller: _cpfCnpjController,
            decoration: const InputDecoration(
              labelText: "CPF ou CNPJ",
            ),
          ),
          TextFormField(
            controller: _cepController,
            decoration: const InputDecoration(
              labelText: "CEP",
            ),
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
                child: const Text("Cadastrar"),
                onPressed: () {
                  // TODO: Implementar lógica de envio do formulário
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
