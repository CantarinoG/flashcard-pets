import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/text_field_wrapper.dart';
import 'package:flutter/material.dart';

class ValueSettingsCard extends StatelessWidget {
  //Mocked data
  final String _title = "Intervalo Máximo de Revisão";
  //final int _initialValue =  1; //Should probably be generic T type once the logic comes in.
  final String _unit = "dias";
  final String _explanation =
      "Qualquer revisão será agendada para, no máximo, daqui a essa quantidade de dias.";
  const ValueSettingsCard({super.key});

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
              TextFieldWrapper(
                hasOutline: true,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixText: _unit,
                    errorText: null,
                  ),
                ),
              ),
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
