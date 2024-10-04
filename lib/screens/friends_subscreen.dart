import 'package:flashcard_pets/providers/services/firebase_auth_provider.dart';
import 'package:flashcard_pets/providers/services/firebase_social_provider.dart';
import 'package:flashcard_pets/widgets/friend_card.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendsSubscreen extends StatelessWidget {
  const FriendsSubscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String userId = Provider.of<FirebaseAuthProvider>(context).uid!;
    final FirebaseSocialProvider socialProvider =
        Provider.of<FirebaseSocialProvider>(context);

    return FutureBuilder<List<String>>(
      future: socialProvider.getFriendsIdList(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar amigos'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const NoItemsPlaceholder(
              "Você ainda não possui amigos adicionados. Cliquem em \"+\" no canto inferior direito da tela e insira o @ do seu amigo para adicionar.");
        } else {
          final List<String> friends = snapshot.data!;
          return ListView.builder(
            itemCount: friends.length,
            itemBuilder: (context, index) {
              return FriendCard(friendId: friends[index]);
            },
          );
        }
      },
    );
  }
}
