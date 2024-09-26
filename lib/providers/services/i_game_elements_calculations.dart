import 'package:flashcard_pets/models/flashcard.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flutter/material.dart';

abstract class IGameElementsCalculations with ChangeNotifier {
  int calculateRevisionRewards(Flashcard flashcard, int quality);
  User addGoldAndXp(User user, int gold, BuildContext context);
}