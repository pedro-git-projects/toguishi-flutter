import 'package:flutter/material.dart';
import 'package:toguishi/screens/unauthenticated/register_groomer_screen.dart';
import 'package:toguishi/screens/unauthenticated/register_store_screen.dart';

class ChoiceScreen extends StatefulWidget {
  const ChoiceScreen({super.key});

  @override
  State<ChoiceScreen> createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  final List<String> options = ['Tosador', 'Lojista'];
  String _selectedOption = 'Tosador';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Você é:'),
            DropdownButton<String>(
              value: _selectedOption,
              items: options
                  .map((el) => DropdownMenuItem(
                        value: el,
                        child: Text(el),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_selectedOption == 'Tosador') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterGroomerScreen(),
                    ),
                  );
                } else if (_selectedOption == 'Lojista') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterStoreScreen(),
                    ),
                  );
                }
              },
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
