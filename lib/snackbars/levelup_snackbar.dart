import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class LevelupSnackbar extends StatelessWidget {
  final int newLevel;
  const LevelupSnackbar(this.newLevel, {super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle? h1 = Theme.of(context).textTheme.headlineLarge;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Subiu de nível!",
          style: body?.copyWith(
            color: primary,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Lvl",
              style: h4.copyWith(color: secondary),
            ),
            Text(
              " $newLevel",
              style: h1?.copyWith(color: secondary),
            ),
          ],
        ),
      ],
    );
  }
}
