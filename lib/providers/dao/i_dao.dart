import 'package:flutter/material.dart';

abstract class IDao<T> with ChangeNotifier {
  Future<void> insert(T item);
  Future<T?> read(int id);
  Future<List<T>> readAll();
  Future<void> update(T item);
  Future<void> delete(int id);
}
