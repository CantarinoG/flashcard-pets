abstract class IJsonDataProvider<T> {
  Future<void> writeData(T data);
  Future<T?> readData();
}
