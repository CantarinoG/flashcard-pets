import 'package:flutter/material.dart';

class ErrorSnackbar extends StatelessWidget {
  final String message;
  const ErrorSnackbar(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color error = Theme.of(context).colorScheme.error;

    return Text(
      message,
      style: body?.copyWith(
        color: error,
      ),
    );
  }
}
