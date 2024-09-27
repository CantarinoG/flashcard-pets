import 'package:flashcard_pets/models/flashcard.dart';
import 'package:flashcard_pets/models/pet.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flutter/material.dart';

abstract class IGameElementsCalculations with ChangeNotifier {
  int calculateRevisionRewards(
    Flashcard flashcard,
    int quality,
    double multiplier,
  );
  User addGoldAndXp(User user, int gold, int xp, BuildContext context,
      {String? optionalMessage});
  Pet addPetCopy(Pet pet, int copies);
}
