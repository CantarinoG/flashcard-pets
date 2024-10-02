import 'package:flashcard_pets/helpers/i_database_helper.dart';
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
        db.execute(
            "CREATE TABLE IF NOT EXISTS Pet ( id TEXT PRIMARY KEY, petBioCode INTEGER NOT NULL, name TEXT, stars INTEGER DEFAULT 0, totalCopies INTEGER DEFAULT 0, currentCopies INTEGER DEFAULT 0, nextStarCopies INTEGER DEFAULT 1, totalXp INTEGER DEFAULT 0, currentXp INTEGER DEFAULT 0, nextLevelXp INTEGER DEFAULT 50, level INTEGER DEFAULT 1, totalGoldSpent INTEGER DEFAULT 0);");
        db.execute(
            "CREATE TABLE IF NOT EXISTS Flashcard ( id TEXT PRIMARY KEY, collectionId TEXT NOT NULL, frontContent TEXT NOT NULL, backContent TEXT NOT NULL, repeticoes INTEGER DEFAULT 0, easeFactor REAL DEFAULT 2.5, interval REAL DEFAULT 0, revisionDate TEXT NOT NULL, audioFiles TEXT NOT NULL, imgFiles TEXT NOT NULL);");
        db.execute(
            "CREATE TABLE IF NOT EXISTS Collection ( id TEXT PRIMARY KEY, name TEXT NOT NULL, subjectCode INTEGER NOT NULL, description TEXT );");
        return db.execute(
            "CREATE TABLE IF NOT EXISTS Media ( id TEXT PRIMARY KEY, fileString TEXT NOT NULL);");
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
