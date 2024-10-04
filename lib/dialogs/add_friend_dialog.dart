import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/widgets/text_field_wrapper.dart';

class AddFriendDialog extends StatefulWidget {
  const AddFriendDialog({super.key});

  @override
  State<AddFriendDialog> createState() => _AddFriendDialogState();
}

class _AddFriendDialogState extends State<AddFriendDialog> {
  static const String _titleText = "Adicionar Amigo";
  static const String _contentText = "Digite o id do amigo que quer adicionar.";
  static const String _cancelText = "Cancelar";
  static const String _confirmText = "Confirmar";
  static const String _idLabelText = "Id";
  static const String _idPrefixText = "id ";
  static const double _contentSpacing = 8.0;

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

  Widget _buildTextField() {
    final Color textColor = Theme.of(context).colorScheme.text;
    return TextFieldWrapper(
      label: _idLabelText,
      child: TextField(
        controller: _textController,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          prefixText: _idPrefixText,
          prefixStyle: TextStyle(color: textColor),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, String text, VoidCallback onPressed) {
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color primary = Theme.of(context).colorScheme.primary;

    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: bodyEm.copyWith(color: primary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color textColor = Theme.of(context).colorScheme.text;

    return AlertDialog(
      title: Text(
        _titleText,
        style: h2?.copyWith(color: secondary),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_contentText, style: bodyEm.copyWith(color: textColor)),
          const SizedBox(height: _contentSpacing),
          _buildTextField(),
        ],
      ),
      actions: [
        _buildActionButton(context, _cancelText, () => _cancel(context)),
        _buildActionButton(context, _confirmText, () => _confirm(context)),
      ],
    );
  }
}
