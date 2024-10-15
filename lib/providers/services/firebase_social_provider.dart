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
      debugPrint(
          "Error on method 'addFriend' in 'FirebaseSocialProvider' class: e");
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
      debugPrint(
          "Error on method 'getFriendsIdList' in 'FirebaseSocialProvider' class: $e");
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
      debugPrint(
          "Error on method 'checkReceivedGifts' in 'FirebaseSocialProvider' class: $e");
      return null;
    }
  }

  Future<String?> receiveGifts(String userId) async {
    try {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);

      final userData = await userDoc.get();
      if (!userData.exists) {
        return null;
      }

      await userDoc.update({'giftTotal': 0});
    } catch (e) {
      debugPrint(
          "Error on method 'receiveGifts' in 'FirebaseSocialProvider' class: $e");
      return "Erro!";
    }
    return null;
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
      debugPrint(
          "Error on method 'canSendGift' in 'FirebaseSocialProvider' class: $e");
      return false;
    }
  }

  Future<String?> sendGift(String userId, String friendId) async {
    try {
      // Update lastTimeSent for the user
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('friends')
          .doc(friendId)
          .set({
        'lastTimeSent': DateTime.now().toIso8601String(),
      }, SetOptions(merge: true));

      // Update or create giftTotal for the friend
      final friendDoc =
          FirebaseFirestore.instance.collection('users').doc(friendId);

      return FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(friendDoc);

        if (!snapshot.exists) {
          throw Exception('Friend document does not exist!');
        }

        final currentGiftTotal = snapshot.data()?['giftTotal'] as int? ?? 0;
        transaction.update(friendDoc, {'giftTotal': currentGiftTotal + 25});

        notifyListeners();
        return null;
      });
    } catch (e) {
      debugPrint(
          "Error on method 'sendGift' in 'FirebaseSocialProvider' class: $e");
      return 'Erro ao enviar presente. Tente novamente mais tarde.';
    }
  }

  Future<List<Map<String, dynamic>>> getTop10GlobalUsers() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .orderBy('totalXp', descending: true)
          .limit(10)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'avatarCode': data['avatarCode'],
          'bgColorCode': data['bgColorCode'],
          'name': data['name'],
          'id': doc.id,
          'totalXp': data['totalXpFromRevisions'],
        };
      }).toList();
    } catch (e) {
      debugPrint(
          "Error on method 'getTop10GlobalUsers' in 'FirebaseSocialProvider' class: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>?> getUserInfo(String userId) async {
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(
          "Error on method 'getUserInfo' in 'FirebaseSocialProvider' class: $e");
      return null;
    }
  }
}
