import 'package:flashcard_pets/widgets/friend_card.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flutter/material.dart';

class FriendsSubscreen extends StatelessWidget {
  //Mocked data
  final List<int> _friends = [1, 2, 3, 4];
  FriendsSubscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _friends.isEmpty
        ? const NoItemsPlaceholder(
            "Você ainda não possui amigos adicionados. Cliquem em \"+\" no canto inferior direito da tela e insira o @ do seu amigo para adicionar.")
        : ListView.builder(
            itemCount: _friends.length,
            itemBuilder: (context, index) {
              return const FriendCard();
            },
          );
  }
}
