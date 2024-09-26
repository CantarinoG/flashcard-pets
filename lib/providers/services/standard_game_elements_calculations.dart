import 'package:flashcard_pets/models/flashcard.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/services/i_game_elements_calculations.dart';
import 'package:flutter/material.dart';

class StandardGameElementsCalculations
    with ChangeNotifier
    implements IGameElementsCalculations {
  @override
  User addGold(User user, int gold) {
    user.gold += gold;
    return user;
  }

  @override
  int calculateRevisionRewards(Flashcard flashcard, int quality) {
    //TODO: Create the logic to actually calculate based on the card's attributes.
    return 10;
  }
}
