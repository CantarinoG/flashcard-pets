import 'package:flashcard_pets/data_providers/i_data_provider.dart';
import 'package:flashcard_pets/models/subject.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/text_field_wrapper.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionFormScreen extends StatefulWidget {
  const CollectionFormScreen({super.key});

  @override
  State<CollectionFormScreen> createState() => _CollectionFormScreenState();
}

class _CollectionFormScreenState extends State<CollectionFormScreen> {
  int _selectedItem = 0;

  void _changeSelectedSubject(int? value) {
    setState(() {
      _selectedItem = value ?? 0;
    });
  }

  void _register() {
    //...
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, Subject> subjects =
        Provider.of<IDataProvider<Subject>>(context).retrieveData();

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
                child: DropdownButton<int>(
                  hint: const Text('Seleciona uma opção'),
                  isExpanded: true,
                  value: _selectedItem,
                  items: subjects.entries.map((entry) {
                    return DropdownMenuItem<int>(
                      value: entry.key,
                      child: Text(entry.value.name),
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
