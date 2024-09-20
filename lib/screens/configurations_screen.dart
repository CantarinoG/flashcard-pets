import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/bool_settings_card.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flashcard_pets/widgets/value_settings_card.dart';
import 'package:flutter/material.dart';

class ConfigurationsScreen extends StatelessWidget {
  //Mocked data:
  late final List<Widget> _settingCards = [
    const BoolSettingsCard(),
    const ValueSettingsCard(),
    const BoolSettingsCard(),
  ];
  ConfigurationsScreen({super.key});

  Widget _buildNotificationSettingCard(BuildContext context) {
    //Mocked data:
    const bool _initialValue = true;

    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color bright = Theme.of(context).colorScheme.bright;

    void _switch(bool value) {
      //...
    }

    void _selectTime() {
      //...
    }

    return SizedBox(
      width: double.infinity,
      child: Card(
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
                  "Lembrete Diário",
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
                ThemedFilledButton(
                  label: "Selecionar Hora",
                  onPressed: _initialValue ? _selectTime : null,
                ),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    _settingCards.insert(
      0,
      _buildNotificationSettingCard(context),
    );

    return Scaffold(
      appBar: const ThemedAppBar("Configurações"),
      body: ScreenLayout(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _settingCards,
          ),
        ),
      ),
    );
  }
}
