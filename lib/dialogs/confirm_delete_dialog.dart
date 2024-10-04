import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  static const String _cancelLabel = "Cancelar";

  final String title;
  final String message;
  final String deleteLabel;
  final Widget? content;

  /// Dialog to confirm deletion.
  ///
  /// [title] The title of the dialog.
  /// [message] The message to display in the dialog.
  /// [deleteLabel] The label for the delete button (default: "Deletar").
  /// [content] Custom content widget to replace the default message text.
  ///
  /// Returns:
  /// - true if the user confirmed.
  /// - false if the user declined.
  /// - null if the user exited.
  const ConfirmDeleteDialog(this.title, this.message,
      {this.deleteLabel = "Deletar", this.content, super.key});

  void _cancel(BuildContext context) => Navigator.of(context).pop(false);
  void _delete(BuildContext context) => Navigator.of(context).pop(true);

  @override
  Widget build(BuildContext context) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color warning = Theme.of(context).colorScheme.warning;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color error = Theme.of(context).colorScheme.error;

    return AlertDialog(
      title: Text(
        title,
        style: h2?.copyWith(
          color: secondary,
        ),
      ),
      content: content ??
          Text(
            message,
            style: bodyEm.copyWith(
              color: warning,
            ),
          ),
      actions: [
        TextButton(
          onPressed: () => _cancel(context),
          child: Text(
            _cancelLabel,
            style: bodyEm.copyWith(
              color: primary,
            ),
          ),
        ),
        TextButton(
          onPressed: () => _delete(context),
          child: Text(
            deleteLabel,
            style: bodyEm.copyWith(color: error),
          ),
        ),
      ],
    );
  }
}
