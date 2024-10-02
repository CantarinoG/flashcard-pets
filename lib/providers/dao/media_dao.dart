import 'package:flashcard_pets/helpers/sqflite_database_helper.dart';
import 'package:flashcard_pets/models/media.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class MediaDao with ChangeNotifier {
  final String tableName = "Media";
  final SqfliteDatabaseHelper databaseHelper = SqfliteDatabaseHelper.instance;

  MediaDao();

  Future<void> insert(Media item) async {
    final database = await databaseHelper.database;
    await database.insert(
      tableName,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<Media?> read(String id) async {
    final database = await databaseHelper.database;
    final maps = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;

    return Media.fromMap(maps.first);
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
}
