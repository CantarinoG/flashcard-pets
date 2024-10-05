import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabaseHelper {
  static const String _databaseName = "flashcard_pets.db";
  static const int _databaseVersion = 1;

  static final SqfliteDatabaseHelper instance = SqfliteDatabaseHelper._();
  Database? _database;

  SqfliteDatabaseHelper._();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createPetTable(db);
    await _createFlashcardTable(db);
    await _createCollectionTable(db);
    await _createMediaTable(db);
  }

  Future<void> _createPetTable(Database db) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS Pet (id TEXT PRIMARY KEY, petBioCode INTEGER NOT NULL, name TEXT, stars INTEGER DEFAULT 0, totalCopies INTEGER DEFAULT 0, currentCopies INTEGER DEFAULT 0, nextStarCopies INTEGER DEFAULT 1, totalXp INTEGER DEFAULT 0, currentXp INTEGER DEFAULT 0, nextLevelXp INTEGER DEFAULT 50, level INTEGER DEFAULT 1, totalGoldSpent INTEGER DEFAULT 0)");
  }

  Future<void> _createFlashcardTable(Database db) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS Flashcard (id TEXT PRIMARY KEY, collectionId TEXT NOT NULL, frontContent TEXT NOT NULL, backContent TEXT NOT NULL, repeticoes INTEGER DEFAULT 0, easeFactor REAL DEFAULT 2.5, interval REAL DEFAULT 0, revisionDate TEXT NOT NULL, audioFiles TEXT NOT NULL, imgFiles TEXT NOT NULL)");
  }

  Future<void> _createCollectionTable(Database db) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS Collection (id TEXT PRIMARY KEY, name TEXT NOT NULL, subjectCode INTEGER NOT NULL, description TEXT)");
  }

  Future<void> _createMediaTable(Database db) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS Media (id TEXT PRIMARY KEY, fileString TEXT NOT NULL)");
  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}
