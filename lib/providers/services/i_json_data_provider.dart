import 'package:flutter/material.dart';

abstract class IJsonDataProvider<T> with ChangeNotifier {
  Future<void> writeData(T data);
  Future<T?> readData();
}
