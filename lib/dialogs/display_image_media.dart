import 'dart:typed_data';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/providers/services/base_64_conversor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayImageMedia extends StatelessWidget {
  final String base64imgString;

  const DisplayImageMedia(this.base64imgString, {super.key});

  void _cancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _delete(BuildContext context) {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color error = Theme.of(context).colorScheme.error;

    final Uint8List imgBytes =
        Provider.of<Base64Conversor>(context).base64ToBytes(base64imgString);

    return AlertDialog(
      title: Text(
        "Exibir imagem",
        style: h2?.copyWith(
          color: secondary,
        ),
      ),
      content: Image.memory(
        imgBytes,
        fit: BoxFit.contain,
      ),
      actions: [
        TextButton(
          onPressed: () {
            _cancel(context);
          },
          child: Text(
            "Voltar",
            style: bodyEm.copyWith(
              color: primary,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            _delete(context);
          },
          child: Text(
            "Excluir",
            style: bodyEm.copyWith(color: error),
          ),
        ),
      ],
    );
  }
}
