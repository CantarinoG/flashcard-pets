import 'package:flutter/material.dart';

abstract class IDao<T> with ChangeNotifier {
  Future<void> insert(T item);
  Future<T?> read(String id);
  Future<List<T>> readAll();
  Future<void> update(T item);
  Future<void> delete(String id);
}
