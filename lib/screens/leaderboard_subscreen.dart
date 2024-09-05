import 'package:flashcard_pets/widgets/leaderboard_user_card.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flutter/material.dart';

class LeaderboardSubscreen extends StatelessWidget {
  //Mocked data
  final List<int> _users = [1, 2, 3];
  LeaderboardSubscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _users.isEmpty
        ? const NoItemsPlaceholder(
            "Algo aconteceu... Não há usuários no placar ou não foi possível carregá-lo. Tente novamente mais tarde.")
        : ListView.builder(
            itemCount: _users.length,
            itemBuilder: (context, index) {
              return const LeaderboardUserCard();
            },
          );
  }
}
