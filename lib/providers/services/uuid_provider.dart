import 'package:flashcard_pets/providers/services/i_id_provider.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UuidProvider with ChangeNotifier implements IIdProvider {
  var uuid = const Uuid();

  @override
  String getUniqueId() {
    return uuid.v4();
  }
}
