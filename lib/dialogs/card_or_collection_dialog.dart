import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';

enum CardOrCollectionDialogResult {
  card,
  collection,
}

class CardOrCollectionDialog extends StatelessWidget {
  const CardOrCollectionDialog({super.key});

  void _chooseCard(BuildContext context) {
    Navigator.pop(context, CardOrCollectionDialogResult.card);
  }

  void _chooseCollection(BuildContext context) {
    Navigator.pop(context, CardOrCollectionDialogResult.collection);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ThemedFilledButton(
            label: "Novo Cartão",
            onPressed: () {
              _chooseCard(context);
            },
            width: 200,
          ),
          const SizedBox(
            height: 8,
          ),
          ThemedFilledButton(
            label: "Novo Conjunto",
            onPressed: () {
              _chooseCollection(context);
            },
            width: 200,
          ),
        ],
      ),
    );
  }
}
