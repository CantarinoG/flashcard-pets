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

      notifyListeners();
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

  Future<int?> checkReceivedGifts(String userId) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        return null;
      }

      return userDoc.data()?['giftTotal'] as int?;
    } catch (e) {
      print('Error checking received gifts: $e');
      return null;
    }
  }

  Future<String?> receiveGifts(String userId) async {
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(userId);

      final userData = await userDoc.get();
      if (!userData.exists) {
        return null;
      }

      await userDoc.update({'giftTotal': 0});
    } catch (e) {
      print('Error receiving gifts: $e');
      return "Erro!";
    }
  }

  Future<bool> canSendGift(String userId, String friendId) async {
    try {
      final friendDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('friends')
          .doc(friendId)
          .get();

      if (!friendDoc.exists) {
        return false;
      }

      final lastTimeSent = friendDoc.data()?['lastTimeSent'] as String?;
      if (lastTimeSent == null) {
        return true;
      }

      final lastSentDateTime = DateTime.parse(lastTimeSent);
      final currentTime = DateTime.now();
      final difference = currentTime.difference(lastSentDateTime);

      return difference.inHours >= 24;
    } catch (e) {
      print('Error checking if can send gift: $e');
      return false;
    }
  }
}
