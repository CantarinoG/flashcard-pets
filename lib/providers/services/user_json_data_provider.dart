import 'dart:convert';
import 'dart:io';
import 'package:flashcard_pets/models/user.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class UserJsonDataProvider with ChangeNotifier {
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

  Future<void> writeData(User user) async {
    try {
      final file = await _getFilePath();
      String jsonString = json.encode(user.toMap());
      await file.writeAsString(jsonString);
      notifyListeners();
    } catch (e) {
      debugPrint(
          "Error in the 'writeData' method, in the 'UserJsonDataProvider' class: $e");
    }
  }

  Future<User?> readData() async {
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
      debugPrint(
          "Error in the 'readData' method, in the 'UserJsonDataProvider' class: $e");
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
      debugPrint(
          "Error in the 'deleteData' method, in the 'UserJsonDataProvider' class: $e");
    }
  }
}
