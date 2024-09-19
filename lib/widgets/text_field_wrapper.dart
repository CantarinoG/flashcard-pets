import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class TextFieldWrapper extends StatelessWidget {
  final String? label;
  final bool hasOutline;
  final Widget child;
  const TextFieldWrapper(
      {required this.child, this.hasOutline = false, this.label, super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final Color brightColor = Theme.of(context).colorScheme.bright;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return Card(
        elevation: 4,
        color: brightColor,
        shape: hasOutline
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: primary, // Color of the border
                  width: 2,
                ),
              )
            : null,
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
