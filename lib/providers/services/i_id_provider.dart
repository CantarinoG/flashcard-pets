import 'package:flutter/material.dart';

abstract class IIdProvider with ChangeNotifier {
  String getUniqueId();
}
