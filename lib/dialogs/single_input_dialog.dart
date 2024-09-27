import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/widgets/text_field_wrapper.dart';
import 'package:flutter/material.dart';

class SingleInputDialog<T> extends StatefulWidget {
  final String title;
  final String description;
  final String label;
  final String? prefixText;
  final String actionText;
  const SingleInputDialog(
      {this.title = "",
      this.description = "",
      this.label = "",
      this.actionText = "Confirmar",
      this.prefixText,
      super.key});

  @override
  State<SingleInputDialog<T>> createState() => _SingleInputDialogState<T>();
}

class _SingleInputDialogState<T> extends State<SingleInputDialog<T>> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _cancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _confirm(BuildContext context) {
    Navigator.of(context).pop(_textController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color primary = Theme.of(context).colorScheme.primary;

    return AlertDialog(
      title: Text(
        widget.title,
        style: h2?.copyWith(
          color: secondary,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.description,
            style: bodyEm,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFieldWrapper(
            label: widget.label,
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                prefixText: widget.prefixText,
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            _cancel(context);
          },
          child: Text(
            "Cancelar",
            style: bodyEm.copyWith(
              color: primary,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            _confirm(context);
          },
          child: Text(
            widget.actionText,
            style: bodyEm.copyWith(
              color: primary,
            ),
          ),
        ),
      ],
    );
  }
}
