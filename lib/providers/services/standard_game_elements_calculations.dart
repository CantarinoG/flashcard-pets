import 'dart:math';

import 'package:flashcard_pets/models/flashcard.dart';
import 'package:flashcard_pets/models/pet.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/services/i_game_elements_calculations.dart';
import 'package:flashcard_pets/snackbars/levelup_snackbar.dart';
import 'package:flashcard_pets/snackbars/pet_levelup_snackbar.dart';
import 'package:flashcard_pets/snackbars/reward_snackbar.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class StandardGameElementsCalculations
    with ChangeNotifier
    implements IGameElementsCalculations {
  @override
  User addGoldAndXp(User user, int gold, int xp, BuildContext context,
      {String? optionalMessage}) {
    if (xp > 0) {
      int initialLevel = user.level;
      user = _addXp(user, xp);
      if (user.level > initialLevel) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: LevelupSnackbar(user.level),
            backgroundColor: Theme.of(context).colorScheme.bright,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }

    if (gold > 0) {
      user.gold += gold;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: RewardSnackbar(
          gold,
          xp,
          optionalMessage: optionalMessage,
        ),
        backgroundColor: Theme.of(context).colorScheme.bright,
        duration: const Duration(seconds: 1),
      ),
    );
    return user;
  }

  User _addXp(User user, int xpValue) {
    user.totalXp += xpValue;
    int totalXp = user.totalXp;

    const int baseXp = 50;
    const double levelMultiplier = 1.1;
    int level = 1;
    int requiredXpForNextLevel = baseXp;

    while (totalXp >= requiredXpForNextLevel) {
      totalXp -= requiredXpForNextLevel;
      level++;
      requiredXpForNextLevel = (baseXp * pow(levelMultiplier, level)).toInt();
    }

    user.level = level;
    user.currentLevelXp = totalXp;
    user.nextLevelXp = requiredXpForNextLevel;

    return user;
  }

  Pet addPetXp(Pet pet, int xpValue, BuildContext context) {
    final int initialLevel = pet.level;
    pet.totalXp += xpValue;
    int totalXp = pet.totalXp;
    const int baseXp = 50;
    const double levelMultiplier = 1.1;
    int level = 1;
    int requiredXpForNextLevel = baseXp;

    while (totalXp >= requiredXpForNextLevel) {
      totalXp -= requiredXpForNextLevel;
      level++;
      requiredXpForNextLevel = (baseXp * pow(levelMultiplier, level)).toInt();
    }

    pet.level = level;
    pet.currentXp = totalXp;
    pet.nextLevelXp = requiredXpForNextLevel;

    if (pet.level > initialLevel) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: PetLevelupSnackbar(pet, true),
          backgroundColor: Theme.of(context).colorScheme.bright,
          duration: const Duration(seconds: 2),
        ),
      );
    }

    return pet;
  }

  @override
  Pet addPetCopy(Pet pet, int copies, BuildContext context) {
    int initialStars = pet.stars;

    pet.totalCopies += copies;
    int totalCopies = pet.totalCopies;

    const int baseCopies = 1;
    const double starMultiplier = 2;
    int stars = 0;
    int requiredCopiesForNextStar = baseCopies;

    while (totalCopies >= requiredCopiesForNextStar && stars < 5) {
      totalCopies -= requiredCopiesForNextStar;
      stars++;
      requiredCopiesForNextStar =
          (baseCopies * pow(starMultiplier, stars)).toInt();
    }

    pet.stars = stars;
    pet.currentCopies = totalCopies;
    pet.nextStarCopies = requiredCopiesForNextStar;

    if (pet.stars > initialStars) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: PetLevelupSnackbar(pet, false),
          backgroundColor: Theme.of(context).colorScheme.bright,
          duration: const Duration(seconds: 2),
        ),
      );
    }

    return pet;
  }

  @override
  int calculateRevisionRewards(
      Flashcard flashcard, int quality, double multiplier) {
    //TODO: Create the logic to actually calculate based on the card's attributes.
    return 10000;
  }

  @override
  int calculateTotalXpToLevel(int level) {
    const int baseXp = 50;
    const double levelMultiplier = 1.1;
    int totalXp = 0;

    for (int i = 1; i < level; i++) {
      int requiredXpForLevel = (baseXp * pow(levelMultiplier, i)).toInt();
      totalXp += requiredXpForLevel;
    }

    return totalXp;
  }
}
