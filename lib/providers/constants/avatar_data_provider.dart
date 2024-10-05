import 'package:flutter/material.dart';

class AvatarDataProvider with ChangeNotifier {
  static const String _basePath = 'assets/images/avatars';

  final Map<int, String> _data = {
    0: '$_basePath/none.png',
    for (int i = 0; i < 6; i++) i + 1: '$_basePath/female_$i.png',
    for (int i = 0; i < 8; i++) i + 7: '$_basePath/male_$i.png',
  };

  Map<int, String> retrieveData() {
    return Map.unmodifiable(_data);
  }

  String retrieveFromKey(int key) {
    return _data[key] ?? _data[0]!;
  }
}
