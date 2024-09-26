import 'package:flashcard_pets/helpers/sqflite_database_helper.dart';
import 'package:flashcard_pets/models/flashcard.dart';
import 'package:flashcard_pets/providers/dao/i_dao.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class FlashcardDao with ChangeNotifier implements IDao<Flashcard> {
  final String tableName = "Flashcard";
  final SqfliteDatabaseHelper databaseHelper = SqfliteDatabaseHelper.instance;

  FlashcardDao();

  @override
  Future<void> insert(Flashcard item) async {
    final database = await databaseHelper.database;
    await database.insert(
      tableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  @override
  Future<Flashcard?> read(String id) async {
    final database = await databaseHelper.database;
    final maps = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;

    return Flashcard.fromMap(maps.first);
  }

  @override
  Future<List<Flashcard>> readAll() async {
    final database = await databaseHelper.database;
    final maps = await database.query(tableName);
    return List.generate(maps.length, (i) => Flashcard.fromMap(maps[i]));
  }

  @override
  Future<List<Flashcard>> customRead(
      String whereClause, List<dynamic> whereArgs) async {
    final database = await databaseHelper.database;
    final maps = await database.query(
      tableName,
      where: whereClause,
      whereArgs: whereArgs,
    );

    return List.generate(maps.length, (i) => Flashcard.fromMap(maps[i]));
  }

  @override
  Future<void> update(Flashcard item) async {
    final database = await databaseHelper.database;
    await database.update(
      tableName,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
    notifyListeners();
  }

  @override
  Future<void> delete(String id) async {
    final database = await databaseHelper.database;
    await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  @override
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
