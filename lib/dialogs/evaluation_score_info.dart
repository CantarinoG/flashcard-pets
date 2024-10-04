import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class EvaluationScoreInfo extends StatelessWidget {
  const EvaluationScoreInfo({super.key});

  static const String _title = "Informação da Avaliação";
  static const String _subtitle =
      "A pontuação da revisão é definida da seguinte forma:";
  static const String _confirmButtonText = "Confirmar";

  static const List<(String, String)> _scoreDescriptions = [
    ("0", "Falha total em relembrar o conteúdo."),
    (
      "1",
      "A resposta fornecida foi incorreta, mas a resposta real parecia familiar."
    ),
    (
      "2",
      "A resposta fornecida foi incorreta, mas o conteúdo foi facilmente lembrado ao ver a resposta real."
    ),
    (
      "3",
      "A resposta fornecida foi correta, mas exigiu um esforço significativo para ser lembrada."
    ),
    (
      "4",
      "A resposta fornecida foi correta, mas houve uma hesitação por parte do usuário."
    ),
    ("5", "A resposta foi recordada perfeitamente."),
  ];

  void _confirm(BuildContext context) {
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color warning = Theme.of(context).colorScheme.warning;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color text = Theme.of(context).colorScheme.text;

    Widget buildScoreItem(
        (String, String) score, TextStyle bodyEm, Color secondary, Color text) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: RichText(
          text: TextSpan(
            style: bodyEm.copyWith(color: text),
            children: [
              TextSpan(
                text: "${score.$1}: ",
                style: bodyEm.copyWith(color: secondary),
              ),
              TextSpan(text: score.$2),
            ],
          ),
        ),
      );
    }

    return AlertDialog(
      title: Text(
        _title,
        style: h2?.copyWith(color: secondary),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _subtitle,
            style: bodyEm.copyWith(color: warning),
          ),
          const SizedBox(height: 8),
          ..._scoreDescriptions
              .map((score) => buildScoreItem(score, bodyEm, secondary, text)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => _confirm(context),
          child: Text(
            _confirmButtonText,
            style: bodyEm.copyWith(color: primary),
          ),
        ),
      ],
    );
  }
}
