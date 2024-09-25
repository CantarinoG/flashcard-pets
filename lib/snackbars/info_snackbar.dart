import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class InfoSnackbar extends StatelessWidget {
  final String message;
  const InfoSnackbar(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color warning = Theme.of(context).colorScheme.warning;

    return Text(
      message,
      style: body?.copyWith(
        color: warning,
      ),
    );
  }
}
