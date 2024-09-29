import 'package:flashcard_pets/models/flashcard.dart';
import 'package:flutter/material.dart';

abstract class ISrsCalculator with ChangeNotifier {
  Flashcard calculateNewValues(Flashcard flashcard, int quality,
      int maxReviewInterval, double reviewMultiplier);
}
