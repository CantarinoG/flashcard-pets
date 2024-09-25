import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class EvaluationScoreInfo extends StatelessWidget {
  const EvaluationScoreInfo({super.key});

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

    return AlertDialog(
      title: Text(
        "Informação da Avaliação",
        style: h2?.copyWith(
          color: secondary,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "A pontuação da revisão é definida da seguinte forma:",
            style: bodyEm.copyWith(color: warning),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: bodyEm.copyWith(color: text),
              children: [
                TextSpan(
                    text: "0: ",
                    style: bodyEm.copyWith(
                      color: secondary,
                    )), // Change color as needed
                const TextSpan(
                  text: "Falha total em relembrar o conteúdo.",
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: bodyEm.copyWith(color: text),
              children: [
                TextSpan(
                    text: "1: ",
                    style: bodyEm.copyWith(
                      color: secondary,
                    )),
                const TextSpan(
                    text:
                        "A resposta fornecida foi incorreta, mas a resposta real parecia familiar."),
              ],
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: bodyEm.copyWith(color: text),
              children: [
                TextSpan(
                    text: "2: ",
                    style: bodyEm.copyWith(
                      color: secondary,
                    )),
                const TextSpan(
                    text:
                        "A resposta fornecida foi incorreta, mas o conteúdo foi facilmente lembrado ao ver a resposta real."),
              ],
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: bodyEm.copyWith(color: text),
              children: [
                TextSpan(
                    text: "3: ",
                    style: bodyEm.copyWith(
                      color: secondary,
                    )),
                const TextSpan(
                    text:
                        "A resposta fornecida foi correta, mas exigiu um esforço significativo para ser lembrada."),
              ],
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: bodyEm.copyWith(color: text),
              children: [
                TextSpan(
                    text: "4: ",
                    style: bodyEm.copyWith(
                      color: secondary,
                    )),
                const TextSpan(
                    text:
                        "A resposta fornecida foi correta, mas houve uma hesitação por parte do usuário."),
              ],
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: bodyEm.copyWith(color: text),
              children: [
                TextSpan(
                    text: "5: ",
                    style: bodyEm.copyWith(
                      color: secondary,
                    )),
                const TextSpan(text: "A resposta foi recordada perfeitamente."),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            _confirm(context);
          },
          child: Text(
            "Confirmar",
            style: bodyEm.copyWith(
              color: primary,
            ),
          ),
        ),
      ],
    );
  }
}
