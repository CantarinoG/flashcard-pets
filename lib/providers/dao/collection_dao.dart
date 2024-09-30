import 'package:flashcard_pets/helpers/sqflite_database_helper.dart';
import 'package:flashcard_pets/models/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class CollectionDao with ChangeNotifier {
  final String tableName = "Collection";
  final SqfliteDatabaseHelper databaseHelper = SqfliteDatabaseHelper.instance;

  CollectionDao();

  Future<void> insert(Collection item) async {
    final database = await databaseHelper.database;
    await database.insert(
      tableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<Collection?> read(String id) async {
    final database = await databaseHelper.database;
    final maps = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;

    return Collection.fromMap(maps.first);
  }

  Future<List<Collection>> readAll() async {
    final database = await databaseHelper.database;
    final maps = await database.query(tableName);
    return List.generate(maps.length, (i) => Collection.fromMap(maps[i]));
  }

  Future<List<Collection>> customRead(
      String whereClause, List<dynamic> whereArgs) async {
    final database = await databaseHelper.database;
    final maps = await database.query(
      tableName,
      where: whereClause,
      whereArgs: whereArgs,
    );

    return List.generate(maps.length, (i) => Collection.fromMap(maps[i]));
  }

  Future<void> update(Collection item) async {
    final database = await databaseHelper.database;
    await database.update(
      tableName,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
    notifyListeners();
  }

  Future<void> delete(String id) async {
    final database = await databaseHelper.database;
    await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<void> customDelete(String whereClause, List whereArgs) async {
    final database = await databaseHelper.database;
    await database.delete(
      tableName,
      where: whereClause,
      whereArgs: whereArgs,
    );
    notifyListeners();
  }
}
