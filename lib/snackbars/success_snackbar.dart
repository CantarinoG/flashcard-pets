import 'package:flutter/material.dart';

class SuccessSnackbar extends StatelessWidget {
  final String message;
  const SuccessSnackbar(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return Text(
      message,
      style: body?.copyWith(
        color: secondary,
      ),
    );
  }
}
