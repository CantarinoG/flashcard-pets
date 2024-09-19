import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/text_field_wrapper.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';

class CollectionFormScreen extends StatefulWidget {
  final List<String> _subjects = [
    "Artes",
    "Ciências",
    "Educação Física",
    "Filosofia",
    "Geografia",
    "História",
    "Informática",
    "Linguagens",
    "Matemática",
    "Diversos",
  ];
  CollectionFormScreen({super.key});

  @override
  State<CollectionFormScreen> createState() => _CollectionFormScreenState();
}

class _CollectionFormScreenState extends State<CollectionFormScreen> {
  late String _selectedItem = widget._subjects[0];

  void _changeSelectedSubject(String? value) {
    setState(() {
      _selectedItem = value ?? widget._subjects[0];
    });
  }

  void _register() {
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemedAppBar("Conjunto"),
      body: ScreenLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TextFieldWrapper(
              label: "Nome",
              child: TextField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Meu conjunto",
                  errorText: null,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFieldWrapper(
              label: "Disciplina",
              child: SizedBox(
                width: double.infinity,
                child: DropdownButton<String>(
                  hint: const Text('Seleciona uma opção'),
                  isExpanded: true,
                  value: _selectedItem,
                  items: widget._subjects.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: _changeSelectedSubject,
                  underline: const SizedBox.shrink(),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Expanded(
              child: TextFieldWrapper(
                label: "Descrição (opcional)",
                child: Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: null,
                    expands: true,
                    scrollPhysics: BouncingScrollPhysics(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Esse conjunto é...",
                      errorText: null,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ThemedFilledButton(label: "Cadastrar", onPressed: _register),
          ],
        ),
      ),
    );
  }
}
