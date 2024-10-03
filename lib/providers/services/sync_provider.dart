import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flutter/material.dart';

class SyncProvider with ChangeNotifier {
  Future<String?> upload(User user, String userId) async {
    final Map<String, dynamic> userMap = user.toMap();
    userMap["lastSync"] = DateTime.now();
    final db = FirebaseFirestore.instance;
    try {
      await db.collection("users").doc(userId).set(userMap);
    } catch (error) {
      print("Error adding document: $error");
      return "Ocorreu algum erro. Tente novamente mais tarde.";
    }
    return null;
  }
}
