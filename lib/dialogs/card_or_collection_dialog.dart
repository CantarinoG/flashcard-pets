import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';

class CardOrCollectionDialog extends StatelessWidget {
  const CardOrCollectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ThemedFilledButton(
            label: "Novo Cartão",
            onPressed: () {},
            width: 200,
          ),
          const SizedBox(
            height: 8,
          ),
          ThemedFilledButton(
            label: "Novo Conjunto",
            onPressed: () {},
            width: 200,
          ),
        ],
      ),
    );
  }
}
