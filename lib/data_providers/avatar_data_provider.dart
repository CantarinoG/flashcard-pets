import 'package:flashcard_pets/data_providers/i_data_provider.dart';
import 'package:flutter/material.dart';

class AvatarDataProvider with ChangeNotifier implements IDataProvider<String> {
  final Map<int, String> _data = {
    0: "assets/images/avatars/female_0.png",
    1: "assets/images/avatars/female_1.png",
    2: "assets/images/avatars/female_2.png",
    3: "assets/images/avatars/female_3.png",
    4: "assets/images/avatars/female_4.png",
    5: "assets/images/avatars/female_5.png",
    6: "assets/images/avatars/male_0.png",
    7: "assets/images/avatars/male_1.png",
    8: "assets/images/avatars/male_2.png",
    9: "assets/images/avatars/male_3.png",
    10: "assets/images/avatars/male_4.png",
    11: "assets/images/avatars/male_5.png",
    12: "assets/images/avatars/male_6.png",
    13: "assets/images/avatars/male_7.png",
  };

  @override
  Map<int, String> retrieveData() {
    return _data;
  }
}
