import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flashcard_pets/helpers/sqflite_database_helper.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/services/user_json_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SyncProvider with ChangeNotifier {
  SqfliteDatabaseHelper dbHelper = SqfliteDatabaseHelper.instance;

  Future<String?> upload(User user, String userId) async {
    final db = FirebaseFirestore.instance;
    final storage = FirebaseStorage.instance;
    final Map<String, dynamic> userMap = user.toMap();
    userMap["lastSync"] = DateTime.now().toIso8601String();
    await dbHelper.close();

    try {
      final String dbPath = join(await getDatabasesPath(), 'flashcard_pets.db');
      final File dbFile = File(dbPath);
      final storageRef =
          storage.ref().child('databases/$userId/flashcard_pets.db');
      // Start the file upload without awaiting it
      storageRef.putFile(dbFile).then((_) {}).catchError((e) {});

      for (int i = 0; i < 15; i++) {
        await Future.delayed(const Duration(seconds: 5));
        try {
          await storageRef.getDownloadURL();
          break;
        } catch (e) {
          if (i == 14) {
            return "Error during file upload: $e";
          }
        }
      }

      // Fetch the existing document
      final docSnapshot = await db.collection("users").doc(userId).get();
      if (docSnapshot.exists) {
        final existingData = docSnapshot.data() as Map<String, dynamic>;
        // Preserve the giftTotal if it exists
        if (existingData.containsKey("giftTotal")) {
          userMap["giftTotal"] = existingData["giftTotal"];
        }
      }

      await db.collection("users").doc(userId).set(userMap);
    } catch (error) {
      debugPrint(
          "Error on the 'upload' method in the 'SyncProvider' class: $error");
      return "Ocorreu algum erro durante a sincronização. Tente novamente mais tarde.";
    }
    return null;
  }

  Future<String?> download(User user, String userId) async {
    final db = FirebaseFirestore.instance;
    final storage = FirebaseStorage.instance;
    await dbHelper.close();

    try {
      final String dbPath = join(await getDatabasesPath(), 'flashcard_pets.db');
      final File dbFile = File(dbPath);
      final storageRef =
          storage.ref().child('databases/$userId/flashcard_pets.db');

      await storageRef.writeToFile(dbFile);

      final docSnapshot = await db.collection("users").doc(userId).get();
      if (!docSnapshot.exists) {
        return "Usuário não encontrado";
      }

      final userData = docSnapshot.data() as Map<String, dynamic>;
      final updatedUser = User.fromMap(userData);

      // Save user data locally
      final UserJsonDataProvider userProvider = UserJsonDataProvider();
      await userProvider.writeData(updatedUser);

      userData["lastSync"] = DateTime.now().toIso8601String();
      await db.collection("users").doc(userId).set(userData);
    } catch (error) {
      debugPrint(
          "Error on the 'download' method in the 'SyncProvider' class: $error");
      return "Ocorreu algum erro durante o download. Tente novamente mais tarde.";
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    final db = FirebaseFirestore.instance;
    try {
      final docSnapshot = await db.collection("users").doc(userId).get();
      if (!docSnapshot.exists) return null;
      final userMap = docSnapshot.data() as Map<String, dynamic>;
      return {
        "lastSync": DateTime.parse(userMap["lastSync"]),
        "level": userMap["level"],
        "gold": userMap["gold"],
        "totalReviewedCards": userMap["totalReviewedCards"],
        "name": userMap["name"],
        "avatarCode": userMap["avatarCode"],
        "bgColorCode": userMap["bgColorCode"],
      };
    } catch (error) {
      debugPrint(
          "Error on the 'getUserData' method in the 'SyncProvider' class: $error");
    }
    return null;
  }
}
