import 'package:flashcard_pets/models/subject.dart';
import 'package:flutter/material.dart';

class SubjectDataProvider with ChangeNotifier {
  final Map<int, Subject> _data = {
    0: const Subject("Artes", "assets/images/icons/arts.svg"),
    1: const Subject("Ciências", "assets/images/icons/sci.svg"),
    2: const Subject("Educação Física", "assets/images/icons/physe.svg"),
    3: const Subject("Filosofia", "assets/images/icons/philo.svg"),
    4: const Subject("Geografia", "assets/images/icons/geo.svg"),
    5: const Subject("História", "assets/images/icons/hist.svg"),
    6: const Subject("Informática", "assets/images/icons/comp.svg"),
    7: const Subject("Linguagens", "assets/images/icons/lang.svg"),
    8: const Subject("Matemática", "assets/images/icons/math.svg"),
    9: const Subject("Diversos", "assets/images/icons/misc.svg"),
  };

  Map<int, Subject> retrieveData() {
    return Map.unmodifiable(_data);
  }

  Subject retrieveFromKey(int key) {
    return _data[key] ?? _data[0]!;
  }
}
