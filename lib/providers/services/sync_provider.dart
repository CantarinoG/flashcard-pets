import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flashcard_pets/helpers/sqflite_database_helper.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SyncProvider with ChangeNotifier {
  SqfliteDatabaseHelper dbHelper = SqfliteDatabaseHelper.instance;

  Future<String?> upload(User user, String userId) async {
    final db = FirebaseFirestore.instance;
    final storage = FirebaseStorage.instance;
    final Map<String, dynamic> userMap = user.toMap();
    userMap["lastSync"] = DateTime.now();
    await dbHelper.close();

    try {
      final String dbPath = join(await getDatabasesPath(), 'flashcard_pets.db');
      final File dbFile = File(dbPath);
      final storageRef =
          storage.ref().child('databases/$userId/flashcard_pets.db');
      // Start the file upload without awaiting it
      storageRef.putFile(dbFile).then((_) {
        print("put db file there");
      }).catchError((e) {
        print("Error during file upload: $e");
      });

      for (int i = 0; i < 15; i++) {
        await Future.delayed(Duration(seconds: 5));
        print(i);
        try {
          await storageRef.getDownloadURL();
          print("File upload confirmed");
          break;
        } catch (e) {
          if (i == 14) {
            print("File upload failed after multiple attempts: $e");
            return "Error during file upload: $e";
          }
        }
      }

      await db.collection("users").doc(userId).set(userMap);
    } catch (error) {
      print("Error during sync: $error");
      return "Ocorreu algum erro durante a sincronização. Tente novamente mais tarde.";
    }
    return null;
  }
}
