import 'package:flashcard_pets/models/flashcard.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/services/i_game_elements_calculations.dart';
import 'package:flashcard_pets/snackbars/reward_snackbar.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class StandardGameElementsCalculations
    with ChangeNotifier
    implements IGameElementsCalculations {
  @override
  User addGoldAndXp(User user, int value, BuildContext context) {
    user.gold += value;
    user.xp += value;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: RewardSnackbar(value),
        backgroundColor: Theme.of(context).colorScheme.bright,
        duration: const Duration(seconds: 1),
      ),
    );
    return user;
  }

  @override
  int calculateRevisionRewards(Flashcard flashcard, int quality) {
    //TODO: Create the logic to actually calculate based on the card's attributes.
    return 10;
  }
}
