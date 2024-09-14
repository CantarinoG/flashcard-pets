import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/widgets/text_field_wrapper.dart';
import 'package:flutter/material.dart';

class AddFriendDialog extends StatelessWidget {
  const AddFriendDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color primary = Theme.of(context).colorScheme.primary;

    return AlertDialog(
      title: Text(
        "Adicionar Amigo",
        style: h2?.copyWith(
          color: secondary,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Insira o @ da pessoa que deseja adicionar como amigo.",
            style: bodyEm,
          ),
          const SizedBox(
            height: 8,
          ),
          const TextFieldWrapper(
            label: "Id do Usuário",
            child: TextField(
              decoration: InputDecoration(
                prefixText: "@",
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Cancelar",
            style: bodyEm.copyWith(
              color: primary,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(
            "Adicionar",
            style: bodyEm.copyWith(
              color: primary,
            ),
          ),
        ),
      ],
    );
  }
}
