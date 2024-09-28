import 'dart:math';
import 'package:flashcard_pets/models/pet.dart';
import 'package:flashcard_pets/models/pet_bio.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/constants/i_data_provider.dart';
import 'package:flashcard_pets/providers/dao/i_dao.dart';
import 'package:flashcard_pets/providers/services/i_game_elements_calculations.dart';
import 'package:flashcard_pets/providers/services/i_id_provider.dart';
import 'package:flashcard_pets/providers/services/i_json_data_provider.dart';
import 'package:flashcard_pets/snackbars/error_snackbar.dart';
import 'package:flashcard_pets/snackbars/pet_got_snackbar.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/store_card.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  void _buy(
    BuildContext context,
    PetRarity commonDrop,
    PetRarity rareDrop,
    User user,
    int price,
  ) async {
    if (user.gold < price) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const ErrorSnackbar(
              "Você não possui moedas o suficiente para comprar esse baú."),
          backgroundColor: Theme.of(context).colorScheme.bright,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    final petsBioMap =
        Provider.of<IDataProvider<PetBio>>(context, listen: false)
            .retrieveData();
    final commonDropKeys = petsBioMap.entries
        .where((entry) => entry.value.rarity == commonDrop)
        .map((entry) => entry.key)
        .toList();
    final rareDropKeys = petsBioMap.entries
        .where((entry) => entry.value.rarity == rareDrop)
        .map((entry) => entry.key)
        .toList();

    final random = Random();
    int randomNumber = random.nextInt(100);

    final gameCalcProvider =
        Provider.of<IGameElementsCalculations>(context, listen: false);
    final List<Pet> petList =
        await Provider.of<IDao<Pet>>(context, listen: false).readAll();
    final double rarePetMultiplier =
        gameCalcProvider.calculateTotalPetBonuses(petList, PetSkill.betterPets);

    int chance = (10 * rarePetMultiplier).round();
    chance = (chance > 80) ? 80 : chance;

    final selectedList = randomNumber < chance ? rareDropKeys : commonDropKeys;

    final int petGotCode = selectedList[random.nextInt(selectedList.length)];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: PetGotSnackbar(petGotCode),
        backgroundColor: Theme.of(context).colorScheme.bright,
        duration: const Duration(seconds: 2),
      ),
    );

    final pet = await Provider.of<IDao<Pet>>(context, listen: false).customRead(
      "petBioCode = ?",
      [petGotCode],
    );

    final gameElementsCalc =
        Provider.of<IGameElementsCalculations>(context, listen: false);
    if (pet.isEmpty) {
      final String uniqueId =
          Provider.of<IIdProvider>(context, listen: false).getUniqueId();
      Pet newPet = Pet(
        uniqueId,
        petGotCode,
        totalGoldSpent: price,
      );
      Provider.of<IDao<Pet>>(context, listen: false).insert(newPet);
    } else if (pet[0].stars == 5) {
      user = gameElementsCalc.addGoldAndXp(user, 0, price, context,
          optionalMessage:
              "Você já possui esse pet com 5 estrelas. Ele será convertido em pontos de experiência.");
    } else {
      // Handle the case where the pet exists but has less than 5 stars
      final updatedPet = gameElementsCalc.addPetCopy(pet[0], 1, context);
      updatedPet.totalGoldSpent += price;
      Provider.of<IDao<Pet>>(context, listen: false).update(updatedPet);
    }

    user.gold -= price;
    Provider.of<IJsonDataProvider<User>>(context, listen: false)
        .writeData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemedAppBar("Loja"),
      body: ScreenLayout(
        child: FutureBuilder(
          future: Provider.of<IJsonDataProvider<User>>(context).readData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else if (snapshot.hasError) {
              return const NoItemsPlaceholder(
                  "Ocorreu algum erro. Tente novamente mais tarde.");
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const NoItemsPlaceholder(
                  "Ocorreu algum erro. Tente novamente mais tarde.");
            } else if (snapshot.hasData && snapshot.data != null) {
              final user = snapshot.data!;
              return Column(
                children: [
                  const UserStatsHeader(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        StoreCard(
                          "Baú Básico",
                          "Geralmente contém um pet de raridade comum. Pequena chance de conter um pet de raridade incomum.",
                          "assets/images/chests/chest0.png",
                          100,
                          0,
                          user.level,
                          onBuy: () => _buy(
                            context,
                            PetRarity.common,
                            PetRarity.uncommon,
                            user,
                            0,
                          ),
                        ),
                        StoreCard(
                          "Baú Médio",
                          "Geralmente contém um pet de raridade incomum. Pequena chance de conter um pet de raridade rara.",
                          "assets/images/chests/chest1.png",
                          300,
                          10,
                          user.level,
                          onBuy: () => _buy(
                            context,
                            PetRarity.uncommon,
                            PetRarity.rare,
                            user,
                            300,
                          ),
                        ),
                        StoreCard(
                          "Baú Superior",
                          "Geralmente contém um pet de raridade rara. Pequena chance de conter um pet de raridade épica.",
                          "assets/images/chests/chest2.png",
                          500,
                          20,
                          user.level,
                          onBuy: () => _buy(context, PetRarity.rare,
                              PetRarity.epic, user, 500),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Text("Ocorreu um erro. Tente novamente mais tarde.");
            }
          },
        ),
      ),
    );
  }
}
