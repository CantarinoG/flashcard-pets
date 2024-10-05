import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class PetTutorialDialog extends StatelessWidget {
  const PetTutorialDialog({super.key});

  static const String _title = "Como Funciona?";
  static const String _content =
      "Esse é seu primeiro animalzinho de estimação.\n\nCada animalzinho possui uma habilidade única, como aumentar a quantidade de ouro e experiência que você ganha.\n\nVocê pode melhorar a habilidade única do seu pet de duas formas: aumentando seu nível ou sua quantidade de estrelas.\n\nAo alimentar seu pet, você gasta seu ouro para dar ao pet pontos de experiência, para que ele aumente seu nível. Quando o nível do pet aumenta, sua habilidade melhora um pouquinho. Além disso, quando o nível do seu pet subir o suficiente, ele se tornará adulto. O nível do pet não pode ser superior ao seu.\n\nAo comprar novos pets, se o pet recebido for da mesma raça de um pet que você já tem, ao invés de ter dois pets repetidos, seu pet ganhará uma cópia. Junte cópias do mesmo pet para aumentar suas estrelas. Cada estrela aumentada aumenta significativamente a habilidade única do pet.\n\nHá 4 raridades de pet: Comum, Incomum, Rara e Épica. Quanto mais raro o pet, melhor sua habilidade. A medida que seu próprio nível for subindo, você desbloqueará novos baús que contém pets mais raros.";
  static const String _confirmButtonText = "Confirmar";

  void _confirm(BuildContext context) {
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color warning = Theme.of(context).colorScheme.warning;
    final Color primary = Theme.of(context).colorScheme.primary;

    return AlertDialog(
      title: Text(
        _title,
        style: h2?.copyWith(color: secondary),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _content,
              style: bodyEm.copyWith(color: warning),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => _confirm(context),
          child: Text(
            _confirmButtonText,
            style: bodyEm.copyWith(color: primary),
          ),
        ),
      ],
    );
  }
}
