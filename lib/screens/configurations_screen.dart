import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/services/i_json_data_provider.dart';
import 'package:flashcard_pets/snackbars/error_snackbar.dart';
import 'package:flashcard_pets/snackbars/success_snackbar.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/bool_settings_card.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_fab.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flashcard_pets/widgets/value_settings_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConfigurationsScreen extends StatefulWidget {
  ConfigurationsScreen({super.key});

  @override
  State<ConfigurationsScreen> createState() => _ConfigurationsScreenState();
}

class _ConfigurationsScreenState extends State<ConfigurationsScreen> {
  late TextEditingController maxReviewController;
  late TextEditingController reviewMultiplierController;

  @override
  void initState() {
    super.initState();
    maxReviewController = TextEditingController();
    reviewMultiplierController = TextEditingController();
  }

  @override
  void dispose() {
    maxReviewController.dispose();
    reviewMultiplierController.dispose();
    super.dispose();
  }

  void _confirm(User user) {
    int? maxReviewInterval = int.tryParse(maxReviewController.text);
    double? reviewMultiplier = double.tryParse(reviewMultiplierController.text);
    print(maxReviewController.text);

    if (maxReviewInterval != null && maxReviewInterval > 0) {
      user.maxReviewInterval = maxReviewInterval;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const ErrorSnackbar(
              "Valor de intervalo máximo de revisões inválido: Valor nulo ou menor ou igual a 0."),
          backgroundColor: Theme.of(context).colorScheme.bright,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    if (reviewMultiplier != null && reviewMultiplier > 0) {
      user.reviewMultiplier = reviewMultiplier;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const ErrorSnackbar(
              "Valor de multiplicador de revisão inválido: Valor nulo ou menor ou igual a 0."),
          backgroundColor: Theme.of(context).colorScheme.bright,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    Provider.of<IJsonDataProvider<User>>(context, listen: false)
        .writeData(user);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const SuccessSnackbar("Novas configurações salvas."),
        backgroundColor: Theme.of(context).colorScheme.bright,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleSoundEffect(bool value, User user) {
    user.userSoundEffects = value;
    Provider.of<IJsonDataProvider<User>>(context, listen: false)
        .writeData(user);
  }

  void _toggleNotifications(bool value, User user) {
    if (value) {
      user.notificationTime = DateTime(DateTime.now().year,
          DateTime.now().month, DateTime.now().day, 8, 0); // 8 am
    } else {
      user.notificationTime = null;
    }
    Provider.of<IJsonDataProvider<User>>(context, listen: false)
        .writeData(user);
  }

  Widget _buildNotificationSettingCard(BuildContext context, DateTime? value,
      void Function(bool)? onChanged, User user) {
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color bright = Theme.of(context).colorScheme.bright;
    final Color text = Theme.of(context).colorScheme.text;

    void selectTime() {
      showTimePicker(
        context: context,
        initialTime: (value == null)
            ? TimeOfDay.fromDateTime(DateTime.now())
            : TimeOfDay.fromDateTime(value),
      ).then((pickedTime) {
        if (pickedTime != null) {
          final now = DateTime.now();
          final newDate = DateTime(
            now.year,
            now.month,
            now.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          user.notificationTime = newDate;
          if (!mounted) return;
          Provider.of<IJsonDataProvider<User>>(context, listen: false)
              .writeData(user);
        }
      });
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
                Switch(
                  value: value == null ? false : true,
                  onChanged: onChanged,
                ),
                if (value != null) ...[
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    DateFormat('HH:mm').format(value),
                    style: h3?.copyWith(color: text),
                  ),
                ],
                const SizedBox(
                  height: 8,
                ),
                ThemedFilledButton(
                  label: "Selecionar Hora",
                  onPressed: value != null ? selectTime : null,
                ),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color text = Theme.of(context).colorScheme.text;

    final IJsonDataProvider<User> userProvider =
        Provider.of<IJsonDataProvider<User>>(context);

    return FutureBuilder<User?>(
      future: userProvider.readData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }

        if (snapshot.hasError) {
          return NoItemsPlaceholder('Error: ${snapshot.error}');
        }

        final user = snapshot.data;
        if (user == null) {
          return const NoItemsPlaceholder('User data not found');
        }

        // Initialize controllers with user data
        maxReviewController =
            TextEditingController(text: user.maxReviewInterval.toString());
        reviewMultiplierController =
            TextEditingController(text: user.reviewMultiplier.toString());

        return Scaffold(
          appBar: const ThemedAppBar("Configurações"),
          body: ScreenLayout(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildNotificationSettingCard(
                    context,
                    user.notificationTime,
                    (value) {
                      _toggleNotifications(value, user);
                    },
                    user,
                  ),
                  ValueSettingsCard(
                    "Intervalo Máximo de Revisões",
                    "Qualquer revisão será agendada para, no máximo, daqui a essa quantidade de dias.",
                    TextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      controller: maxReviewController,
                      style: body?.copyWith(
                        color: text,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixText: "dias",
                        suffixStyle: body?.copyWith(
                          color: text,
                        ),
                        errorText: null,
                      ),
                    ),
                  ),
                  ValueSettingsCard(
                    "Multiplicador do Intervalo de Revisões",
                    "Serve para aumentar ou diminuir a frequência das revisões. O valor padrão é 1. Para revisões mais frequentes, coloque valores entre 0 e 1. Para revisões menos frequentes, coloque valores maiores que 1.",
                    TextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      controller: reviewMultiplierController,
                      style: body?.copyWith(
                        color: text,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixText: "*",
                        suffixStyle: body?.copyWith(
                          color: text,
                        ),
                        errorText: null,
                      ),
                    ),
                  ),
                  BoolSettingsCard(
                    "Habilitar Efeitos Sonoros",
                    "Habilita ou desabilita efeitos sonoros no aplicativo.",
                    Switch(
                      value: user.userSoundEffects,
                      onChanged: (value) {
                        _toggleSoundEffect(value, user);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: ThemedFab(
            () {
              _confirm(user);
            },
            const Icon(Icons.save),
          ),
        );
      },
    );
  }
}
