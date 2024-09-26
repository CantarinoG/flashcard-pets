import 'package:flashcard_pets/helpers/sqflite_database_helper.dart';
import 'package:flashcard_pets/models/pet.dart';
import 'package:flashcard_pets/providers/dao/i_dao.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class PetDao with ChangeNotifier implements IDao<Pet> {
  final String tableName = "Pet";
  final SqfliteDatabaseHelper databaseHelper = SqfliteDatabaseHelper.instance;

  PetDao();

  @override
  Future<void> insert(Pet item) async {
    final database = await databaseHelper.database;
    await database.insert(
      tableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  @override
  Future<Pet?> read(String id) async {
    final database = await databaseHelper.database;
    final maps = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;

    return Pet.fromMap(maps.first);
  }

  @override
  Future<List<Pet>> readAll() async {
    final database = await databaseHelper.database;
    final maps = await database.query(tableName);
    return List.generate(maps.length, (i) => Pet.fromMap(maps[i]));
  }

  @override
  Future<List<Pet>> customRead(
      String whereClause, List<dynamic> whereArgs) async {
    final database = await databaseHelper.database;
    final maps = await database.query(
      tableName,
      where: whereClause,
      whereArgs: whereArgs,
    );

    return List.generate(maps.length, (i) => Pet.fromMap(maps[i]));
  }

  @override
  Future<void> update(Pet item) async {
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
