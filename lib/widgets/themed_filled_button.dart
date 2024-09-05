import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class ThemedFilledButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final double? width;
  const ThemedFilledButton(
      {required this.label, required this.onPressed, this.width, super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;

    return SizedBox(
      width: width,
      child: FilledButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: bodyEm,
        ),
      ),
    );
  }
}
