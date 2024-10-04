import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';

enum CardOrCollectionDialogResult {
  card,
  collection,
}

class CardOrCollectionDialog extends StatelessWidget {
  const CardOrCollectionDialog({super.key});

  static const double _buttonWidth = 200;

  @override
  Widget build(BuildContext context) {
    void chooseOption(CardOrCollectionDialogResult result) {
      Navigator.pop(context, result);
    }

    Widget buildButton(String label, CardOrCollectionDialogResult result) {
      return ThemedFilledButton(
        label: label,
        onPressed: () => chooseOption(result),
        width: _buttonWidth,
      );
    }

    final List<Map<String, dynamic>> buttons = [
      {'label': 'Novo Cartão', 'result': CardOrCollectionDialogResult.card},
      {
        'label': 'Novo Conjunto',
        'result': CardOrCollectionDialogResult.collection
      },
    ];

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: buttons.map((button) {
          return Column(
            children: [
              buildButton(button['label'], button['result']),
              if (button != buttons.last) const SizedBox(height: 8),
            ],
          );
        }).toList(),
      ),
    );
  }
}
