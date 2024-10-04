import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseSocialProvider with ChangeNotifier {
  Future<String?> addFriend(String userId, String friendId) async {
    try {
      final friendDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(friendId)
          .get();

      if (!friendDoc.exists) {
        return 'Usuário não encontrado.';
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('friends')
          .doc(friendId)
          .set({});

      return null;
    } catch (e) {
      print('Error adding friend: $e');
      return 'Um erro ocorreu enquanto tentava adicionar um amigo. Tente novamente mais tarde.';
    }
  }

  Future<List<String>> getFriendsIdList(String userId) async {
    try {
      final friendsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('friends')
          .get();

      return friendsSnapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print('Error getting friends list: $e');
      return [];
    }
  }
}
