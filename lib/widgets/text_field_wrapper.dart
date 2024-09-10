import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class TextFieldWrapper extends StatelessWidget {
  final String? label;
  final Widget child;
  const TextFieldWrapper({required this.child, this.label, super.key});

  @override
  Widget build(BuildContext context) {
    final Color brightColor = Theme.of(context).colorScheme.bright;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;

    return Card(
        elevation: 4,
        color: brightColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          child: Column(
            children: [
              if (label != null)
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    label ?? "",
                    style: h3?.copyWith(
                      color: secondary,
                    ),
                  ),
                ),
              child,
            ],
          ),
        ));
  }
}
