import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class BoolSettingsCard extends StatelessWidget {
  //Mocked Data
  final String _title = "Habilitar Efeitos Sonoros";
  final bool _initialValue = true;
  final String _explanation =
      "Habilita ou desabilita os efeitos sonoros disparados ao avaliar a qualidade de uma revisão.";
  //Should also receive a function to do something with the value inputed.
  const BoolSettingsCard({super.key});

  void _switch(bool value) {
    //...
  }

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
                _title,
                style: h3?.copyWith(
                  color: secondary,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Switch(value: _initialValue, onChanged: _switch),
              const SizedBox(
                height: 8,
              ),
              Text(
                _explanation,
                style: body?.copyWith(
                  color: disabled,
                ),
              ),
            ],
          ),
        ));
  }
}
