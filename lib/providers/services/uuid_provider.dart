import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UuidProvider with ChangeNotifier {
  var uuid = const Uuid();

  String getUniqueId() {
    return uuid.v4();
  }
}
