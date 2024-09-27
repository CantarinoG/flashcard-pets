import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/services/i_game_elements_calculations.dart';
import 'package:flashcard_pets/providers/services/i_json_data_provider.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/text_field_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FeedPetDialog extends StatefulWidget {
  final pet;
  const FeedPetDialog(this.pet, {super.key});

  @override
  State<FeedPetDialog> createState() => _FeedPetDialog();
}

class _FeedPetDialog<T> extends State<FeedPetDialog> {
  //TODO: Calculate pet bonuses
  //Mocked data
  final int xpPerCoin = 3;

  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _cancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _confirm(BuildContext context) async {
    final userProvider =
        Provider.of<IJsonDataProvider<User>>(context, listen: false);
    final user = await userProvider.readData();
    if (user == null) return;
    int feedAmount = int.tryParse(_textController.text) ?? 0;
    if (feedAmount > user.gold) {
      feedAmount = user.gold;
    }
    user.gold -= feedAmount;
    await userProvider.writeData(user);
    Navigator.of(context).pop(int.parse(_textController.text) * xpPerCoin);
  }

  void _limitValue(String value) async {
    final user =
        await Provider.of<IJsonDataProvider<User>>(context, listen: false)
            .readData();
    if (user == null) return;
    final userGold = user.gold;
    int? intValue = int.tryParse(value);
    if (intValue != null && intValue > userGold) {
      _textController.text = userGold.toString();
      _textController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textController.text.length),
      );
    }
    final userLevel = user.level;
    final gameElementsCalculator =
        Provider.of<IGameElementsCalculations>(context, listen: false);
    final totalXpToMaxLevel =
        gameElementsCalculator.calculateTotalXpToLevel(userLevel);
    final maxXp = totalXpToMaxLevel - widget.pet.totalXp;
    final maxCoinsToSpent = (maxXp / xpPerCoin).ceil();
    if (intValue != null && intValue > maxCoinsToSpent) {
      _textController.text = maxCoinsToSpent.toString();
      _textController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textController.text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color text = Theme.of(context).colorScheme.text;

    return AlertDialog(
      title: Text(
        "Alimentar Pet",
        style: h2?.copyWith(
          color: secondary,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "A cada moeda, o pet é alimentado e ganha ${xpPerCoin}",
                  style: bodyEm.copyWith(
                    color: text,
                  ),
                ),
                TextSpan(
                  text: "XP",
                  style: h4.copyWith(
                    color: secondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFieldWrapper(
            label: "Número de Moedas",
            child: TextField(
              controller: _textController,
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                prefixText: "\$",
                border: InputBorder.none,
              ),
              onChanged: _limitValue,
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
            "Alimentar",
            style: bodyEm.copyWith(
              color: primary,
            ),
          ),
        ),
      ],
    );
  }
}
