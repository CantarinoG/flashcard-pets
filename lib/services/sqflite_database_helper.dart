import 'package:flashcard_pets/services/i_database_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabaseHelper implements IDatabaseHelper {
  static const String _databaseName = "flashcard_pets.db";
  static final SqfliteDatabaseHelper instance =
      SqfliteDatabaseHelper._privateConstructor();
  Database? _database;

  SqfliteDatabaseHelper._privateConstructor();

  @override
  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, _databaseName),
      version: 1,
      onOpen: (db) {
        return db.execute(
            "CREATE TABLE IF NOT EXISTS Collection ( id TEXT PRIMARY KEY, name TEXT NOT NULL, subjectCode INTEGER NOT NULL, description TEXT );");
      },
    );
  }

  @override
  Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  @override
  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}
