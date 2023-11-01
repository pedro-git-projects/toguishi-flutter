import 'package:flutter/material.dart';

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
      ],
    );
  }
}
