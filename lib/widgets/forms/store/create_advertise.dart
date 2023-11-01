import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toguishi/state/config_provider.dart';
import 'package:toguishi/state/storage_service.dart';

import 'package:http/http.dart' as http;

class CreateAdvertiseForm extends StatefulWidget {
  const CreateAdvertiseForm({super.key});

  @override
  CreateAdvertiseFormState createState() => CreateAdvertiseFormState();
}

class CreateAdvertiseFormState extends State<CreateAdvertiseForm> {
  List<String> selectedOptions = [];
  final descricaoController = TextEditingController();
  final remuneracaoController = TextEditingController();
  final beneficiosController = TextEditingController();
  final experienciaController = TextEditingController();

  void _showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(''),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

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

  Future<void> _submitAdvertisement() async {
    String descricao = descricaoController.text;
    String remuneracao = remuneracaoController.text;
    String beneficios = beneficiosController.text;
    String experiencia = experienciaController.text;
    List<String> selectedOptions = this.selectedOptions;

    final config = Provider.of<ConfigProvider>(context, listen: false);
    final ip = config.ip;

    final requestBody = jsonEncode({
      "Descrição": descricao,
      "Remuneração": remuneracao,
      "Benefícios": beneficios,
      "Experiência": experiencia,
      "Selected Options": selectedOptions,
    });

    print(requestBody);

    final token = await StorageService().read('token');

    final response = await http.post(
      Uri.parse('http://$ip:3000/advertisement'),
      headers: {
        'Cotent-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: requestBody,
    );

    if (response.statusCode == 201) {
      final message = jsonDecode(response.body)['message'];
      _showMessageDialog(message);
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: descricaoController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText:
                  'Descreva as qualificações e experiências desejadas para o tosador'),
          maxLines: 5,
        ),
        TextFormField(
          controller: remuneracaoController,
          decoration: const InputDecoration(labelText: 'Remuneração'),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          controller: beneficiosController,
          decoration: const InputDecoration(labelText: 'Benefícios (opcional)'),
        ),
        TextFormField(
          controller: experienciaController,
          decoration:
              const InputDecoration(labelText: 'Experiência (anos, opcional)'),
          keyboardType: TextInputType.number,
        ),
        CheckboxListTile(
          title: const Text("Banho"),
          value: selectedOptions.contains("Banho"),
          onChanged: (value) {
            setState(() {
              if (selectedOptions.contains("Banho")) {
                selectedOptions.remove("Banho");
              } else {
                selectedOptions.add("Banho");
              }
            });
          },
        ),
        CheckboxListTile(
          title: const Text("Tosa"),
          value: selectedOptions.contains("Tosa"),
          onChanged: (value) {
            setState(() {
              if (selectedOptions.contains("Tosa")) {
                selectedOptions.remove("Tosa");
              } else {
                selectedOptions.add("Tosa");
              }
            });
          },
        ),
        CheckboxListTile(
          title: const Text("Penteados"),
          value: selectedOptions.contains("Penteados"),
          onChanged: (value) {
            setState(() {
              if (selectedOptions.contains("Penteados")) {
                selectedOptions.remove("Penteados");
              } else {
                selectedOptions.add("Penteados");
              }
            });
          },
        ),
        ElevatedButton(
          onPressed: _submitAdvertisement,
          child: const Text("Criar Anúncio"),
        ),
      ],
    );
  }
}
