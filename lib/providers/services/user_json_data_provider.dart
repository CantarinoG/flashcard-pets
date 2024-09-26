import 'dart:convert';
import 'dart:io';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/services/i_json_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class UserJsonDataProvider
    with ChangeNotifier
    implements IJsonDataProvider<User> {
  UserJsonDataProvider._privateConstructor();

  static final UserJsonDataProvider _instance =
      UserJsonDataProvider._privateConstructor();

  factory UserJsonDataProvider() {
    return _instance;
  }

  final String _fileName = 'user_data_fp.json';

  Future<File> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  @override
  Future<void> writeData(User user) async {
    try {
      final file = await _getFilePath();
      String jsonString = json.encode(user.toMap());
      await file.writeAsString(jsonString);
      notifyListeners();
    } catch (e) {
      debugPrint("Error writing to file: $e");
    }
  }

  @override
  Future<User?> readData() async {
    //await deleteData();
    try {
      final file = await _getFilePath();
      if (await file.exists()) {
        String jsonString = await file.readAsString();
        final dataMap = json.decode(jsonString);
        return User.fromMap(dataMap);
      }
      final defaultUser = User();
      await writeData(defaultUser);
      return defaultUser;
    } catch (e) {
      debugPrint("Error reading file: $e");
      return null;
    }
  }

  Future<void> deleteData() async {
    try {
      final file = await _getFilePath();
      if (await file.exists()) {
        await file.delete();
        notifyListeners();
        debugPrint("User data deleted successfully.");
      } else {
        debugPrint("No user data to delete.");
      }
    } catch (e) {
      debugPrint("Error deleting file: $e");
    }
  }
}
