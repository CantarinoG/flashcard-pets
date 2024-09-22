import 'package:flutter/material.dart';

abstract class IDataProvider<T> with ChangeNotifier {
  Map<int, T> retrieveData();
}
