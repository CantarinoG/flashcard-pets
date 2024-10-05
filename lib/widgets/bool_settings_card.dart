import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class BoolSettingsCard extends StatelessWidget {
  final String title;
  final String explanation;
  final Widget switchWidget;
  const BoolSettingsCard(this.title, this.explanation, this.switchWidget,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;

    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color disabled = Theme.of(context).disabledColor;
    final Color bright = Theme.of(context).colorScheme.bright;

    return Card(
        elevation: 4,
        color: bright,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: Column(
            children: [
              Text(
                title,
                style: h3?.copyWith(
                  color: secondary,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              switchWidget,
              const SizedBox(
                height: 8,
              ),
              Text(
                explanation,
                style: body?.copyWith(
                  color: disabled,
                ),
              ),
            ],
          ),
        ));
  }
}
