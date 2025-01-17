// ignore_for_file: use_build_context_synchronously

import 'package:flashcard_pets/models/pet.dart';
import 'package:flashcard_pets/models/pet_bio.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/dao/pet_dao.dart';
import 'package:flashcard_pets/providers/services/standard_game_elements_calculations.dart';
import 'package:flashcard_pets/providers/services/user_json_data_provider.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/text_field_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FeedPetDialog extends StatefulWidget {
  final Pet pet;
  const FeedPetDialog(this.pet, {super.key});

  @override
  State<FeedPetDialog> createState() => _FeedPetDialogState();
}

class _FeedPetDialogState extends State<FeedPetDialog> {
  static const int _baseXpPerCoin = 3;
  int _xpPerCoin = _baseXpPerCoin;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPetXpMultiplier();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _loadPetXpMultiplier() async {
    final gameCalcProvider =
        Provider.of<StandardGameElementsCalculations>(context, listen: false);
    final List<Pet> petList =
        await Provider.of<PetDao>(context, listen: false).readAll();
    final double petXpMultiplier = gameCalcProvider.calculateTotalPetBonuses(
        petList, PetSkill.cheaperUpgrade);
    setState(() {
      _xpPerCoin = (_baseXpPerCoin * petXpMultiplier).round();
    });
  }

  void _cancel(BuildContext context) => Navigator.of(context).pop();

  void _confirm(BuildContext context) async {
    final userProvider =
        Provider.of<UserJsonDataProvider>(context, listen: false);
    final user = await userProvider.readData();
    if (user == null) return;

    int feedAmount = int.tryParse(_textController.text) ?? 0;
    feedAmount = feedAmount.clamp(0, user.gold);

    user.gold -= feedAmount;
    user.totalGoldSpent += feedAmount;
    user.totalPetXp += feedAmount * _xpPerCoin;
    await userProvider.writeData(user);

    widget.pet.totalGoldSpent += feedAmount;
    Provider.of<PetDao>(context, listen: false).update(widget.pet);

    Navigator.of(context).pop(feedAmount * _xpPerCoin);
  }

  void _limitValue(String value) async {
    final user = await Provider.of<UserJsonDataProvider>(context, listen: false)
        .readData();
    if (user == null) return;

    final gameElementsCalculator =
        Provider.of<StandardGameElementsCalculations>(context, listen: false);
    final totalXpToMaxLevel =
        gameElementsCalculator.calculateTotalXpToLevel(user.level);
    final maxXp = totalXpToMaxLevel - widget.pet.totalXp;

    final maxCoinsToSpent = (maxXp / _xpPerCoin).ceil();
    final maxValue = maxCoinsToSpent.clamp(0, user.gold);

    int? intValue = int.tryParse(value);
    if (intValue != null && intValue > maxValue) {
      _textController.text = maxValue.toString();
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
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color text = Theme.of(context).colorScheme.text;

    final userProvider =
        Provider.of<UserJsonDataProvider>(context, listen: false);

    return FutureBuilder<User?>(
      future: userProvider.readData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else if (snapshot.hasError) {
          return NoItemsPlaceholder('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const NoItemsPlaceholder('No user data available');
        }

        final user = snapshot.data!;

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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "assets/images/custom_icons/coin.svg",
                    width: 30,
                    height: 30,
                  ),
                  Text(
                    " ${user.gold}",
                    style: body,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "A cada moeda, o pet é alimentado e ganha $_xpPerCoin",
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
                  style: TextStyle(color: text),
                  decoration: InputDecoration(
                    prefixText: "\$",
                    prefixStyle: TextStyle(color: text),
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
      },
    );
  }
}
