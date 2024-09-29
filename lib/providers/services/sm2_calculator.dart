import 'package:flashcard_pets/models/flashcard.dart';
import 'package:flashcard_pets/providers/services/i_srs_calculator.dart';
import 'package:flutter/material.dart';

class Sm2Calculator with ChangeNotifier implements ISrsCalculator {
  @override
  Flashcard calculateNewValues(Flashcard flashcard, int quality,
      int maxReviewInterval, double reviewMultiplier) {
    double easinessFactor = flashcard.easeFactor;
    double interval = flashcard.interval;
    int repetitions = flashcard.repeticoes;

    if (quality >= 3) {
      if (repetitions == 0) {
        interval = 1;
      } else if (repetitions == 1) {
        interval = 6;
      } else {
        interval = (interval * easinessFactor).round() as double;
      }
      repetitions += 1;
    } else {
      repetitions = 0;
      interval = 1;
    }

    easinessFactor =
        easinessFactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    if (easinessFactor < 1.3) {
      easinessFactor = 1.3;
    }

    interval = interval * reviewMultiplier;

    if (interval > maxReviewInterval) {
      interval = maxReviewInterval.toDouble();
    }

    flashcard.interval = interval;
    flashcard.easeFactor = easinessFactor;
    flashcard.repeticoes = repetitions;
    flashcard.revisionDate =
        flashcard.revisionDate.add(Duration(days: interval.ceil()));

    return flashcard;
  }
}
