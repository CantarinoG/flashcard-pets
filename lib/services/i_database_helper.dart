abstract class IDatabaseHelper<T> {
  IDatabaseHelper.privateConstructor();

  static IDatabaseHelper? instance;

  Future<T> initDatabase();

  Future<T> get database;

  Future<void> close();
}
