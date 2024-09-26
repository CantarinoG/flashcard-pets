import 'dart:math';

import 'package:flashcard_pets/models/flashcard.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/services/i_game_elements_calculations.dart';
import 'package:flashcard_pets/snackbars/levelup_snackbar.dart';
import 'package:flashcard_pets/snackbars/reward_snackbar.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class StandardGameElementsCalculations
    with ChangeNotifier
    implements IGameElementsCalculations {
  @override
  User addGoldAndXp(User user, int value, BuildContext context) {
    int initialLevel = user.level;
    user = _addXp(user, value);
    if (user.level > initialLevel) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: LevelupSnackbar(user.level),
          backgroundColor: Theme.of(context).colorScheme.bright,
          duration: const Duration(seconds: 2),
        ),
      );
    }
    user.gold += value;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: RewardSnackbar(value),
        backgroundColor: Theme.of(context).colorScheme.bright,
        duration: const Duration(seconds: 1),
      ),
    );
    return user;
  }

  User _addXp(User user, int value) {
    user.totalXp += value;
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

  @override
  int calculateRevisionRewards(Flashcard flashcard, int quality) {
    //TODO: Create the logic to actually calculate based on the card's attributes.
    return 10;
  }
}
