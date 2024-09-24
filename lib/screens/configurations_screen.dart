import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/bool_settings_card.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_fab.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flashcard_pets/widgets/value_settings_card.dart';
import 'package:flutter/material.dart';

class ConfigurationsScreen extends StatelessWidget {
  const ConfigurationsScreen({super.key});

  void _confirm() {
    //...
  }

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
    return Scaffold(
      appBar: const ThemedAppBar("Configurações"),
      body: ScreenLayout(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            _buildNotificationSettingCard(context),
            const ValueSettingsCard(
                "Intervalo Máximo de Revisões",
                "Qualquer revisão será agendada para, no máximo, daqui a essa quantidade de dias.",
                "dias"),
            const ValueSettingsCard(
                "Multiplicador do Intervalo de Revisões",
                "Serve para aumentar ou diminuir a frequência das revisões. O valor padrão é 1. Para revisões mais frequentes, coloque valores entre 0 e 1. Para revisões menos frequentes, coloque valores maiores que 1.",
                "*"),
            const ValueSettingsCard(
              "Número Máximo de Cartões Diários",
              "O número máximo de cartões que podem ser agendados para um determinado dia.",
              "",
            ),
            const BoolSettingsCard(
              "Habilitar Efeitos Sonoros",
              "Habilita ou desabilita efeitos sonoros no aplicativo.",
            ),
            const BoolSettingsCard(
              "Habilitar Sincronização Automática",
              "Se estiver logado, os dados do seu perfil são sincronizados automaticamente.",
            ),
          ]),
        ),
      ),
      floatingActionButton: ThemedFab(
        _confirm,
        const Icon(Icons.check),
      ),
    );
  }
}
