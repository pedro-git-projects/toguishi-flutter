import 'package:flutter/material.dart';
import 'package:toguishi/screens/unauthenticated/register_groomer_screen.dart';
import 'package:toguishi/screens/unauthenticated/register_store_screen.dart';

class ChooseUserType extends StatelessWidget {
  const ChooseUserType({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Criar conta para:",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterGroomerScreen(),
                  ),
                );
              },
              child:
                  const Text("Tosador", style: TextStyle(color: Colors.white)),
            ),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterStoreScreen(),
                  ),
                );
              },
              child:
                  const Text("Lojista", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }
}
