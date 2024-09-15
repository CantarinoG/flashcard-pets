import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/text_field_wrapper.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';

class CardFormScreen extends StatefulWidget {
  //Mocked data
  final List<String> _collections = [
    "AEDs",
    "Sistemas Operacionais",
    "Linguagens de Programação",
  ];
  final List<int> _audioFiles = [1, 2];
  final List<int> _imgFiles = [1];
  CardFormScreen({super.key});

  @override
  State<CardFormScreen> createState() => _CardFormScreenState();
}

class _CardFormScreenState extends State<CardFormScreen> {
  String _selectedItem = "AEDs";

  void _registerCard(BuildContext context) {
    Navigator.of(context).pop();
  }

  List<Widget> _buildAudioMediaWidgets(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color bright = Theme.of(context).colorScheme.bright;

    return widget._audioFiles.map((int img) {
      return Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: const Icon(Icons.mic),
          color: bright,
          onPressed: () {},
        ),
      );
    }).toList();
  }

  List<Widget> _buildImgMediaWidgets(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;

    return widget._imgFiles.map((int img) {
      return Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: primary,
            width: 2,
          ),
        ),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/images/baby_pets/beagle.png", //mocked, also, should put a default image if not valid
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color bright = Theme.of(context).colorScheme.bright;

    return Scaffold(
      appBar: const ThemedAppBar("Cartão"),
      body: ScreenLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFieldWrapper(
              label: "Conjunto",
              child: SizedBox(
                width: double.infinity,
                child: DropdownButton<String>(
                  hint: const Text('Seleciona uma opção'),
                  isExpanded: true,
                  value: _selectedItem,
                  items: widget._collections.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItem = newValue ?? "";
                    });
                  },
                  underline: const SizedBox.shrink(),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const TextFieldWrapper(
              label: "Frente",
              child: TextField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorText: null,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Expanded(
              child: TextFieldWrapper(
                label: "Verso",
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
                      errorText: null,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFieldWrapper(
              label: "Mídia(Opcional)",
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ..._buildAudioMediaWidgets(context),
                    ..._buildImgMediaWidgets(context),
                    Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        color: bright,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ThemedFilledButton(
                label: "Cadastrar",
                onPressed: () {
                  _registerCard(context);
                }),
          ],
        ),
      ),
    );
  }
}
