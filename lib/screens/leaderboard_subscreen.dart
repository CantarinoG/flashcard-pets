import 'package:flashcard_pets/widgets/leaderboard_user_card.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';

class LeaderboardSubscreen extends StatelessWidget {
  //Mocked data
  final List<int> _users = [1, 2, 3];
  final int _pontos = 234;
  LeaderboardSubscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;

    return _users.isEmpty
        ? const NoItemsPlaceholder(
            "Algo aconteceu... Não há usuários no placar ou não foi possível carregá-lo. Tente novamente mais tarde.")
        : Column(
            children: [
              const SizedBox(
                height: 6,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ThemedFilledButton(
                      label: "Data",
                      leadingIcon: const Icon(Icons.calendar_month),
                      onPressed: () {},
                      isBold: false,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ThemedFilledButton(
                      label: "Disciplina",
                      leadingIcon: const Icon(Icons.menu_book),
                      onPressed: () {},
                      isBold: false,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ThemedFilledButton(
                      label: "Público",
                      leadingIcon: const Icon(Icons.public),
                      onPressed: () {},
                      isBold: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    return const LeaderboardUserCard();
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Seus pontos: $_pontos",
                style: h3?.copyWith(color: secondary),
              ),
            ],
          );
  }
}
