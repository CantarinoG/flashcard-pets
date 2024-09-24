import 'package:flashcard_pets/models/subject.dart';
import 'package:flashcard_pets/providers/constants/i_data_provider.dart';
import 'package:flutter/material.dart';

class SubjectDataProvider
    with ChangeNotifier
    implements IDataProvider<Subject> {
  final Map<int, Subject> _data = {
    0: Subject("Artes", "assets/images/icons/arts.svg"),
    1: Subject("Ciências", "assets/images/icons/sci.svg"),
    2: Subject("Educação Física", "assets/images/icons/physe.svg"),
    3: Subject("Filosofia", "assets/images/icons/philo.svg"),
    4: Subject("Geografia", "assets/images/icons/geo.svg"),
    5: Subject("História", "assets/images/icons/hist.svg"),
    6: Subject("Informática", "assets/images/icons/comp.svg"),
    7: Subject("Linguagens", "assets/images/icons/lang.svg"),
    8: Subject("Matemática", "assets/images/icons/math.svg"),
    9: Subject("Diversos", "assets/images/icons/misc.svg"),
  };

  @override
  Map<int, Subject> retrieveData() {
    return _data;
  }

  @override
  Subject retrieveFromKey(int key) {
    return _data[key] ?? _data[0]!;
  }
}
