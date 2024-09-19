import 'package:flashcard_pets/dialogs/leaderboard_filter_dialog.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/widgets/leaderboard_user_card.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';

class LeaderboardSubscreen extends StatelessWidget {
  //Mocked data
  final List<int> _users = [1, 2, 3];
  final int _pontos = 234;
  LeaderboardSubscreen({super.key});

  void _filterByDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
  }

  void _filterBySubject(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LeaderboardFilterDialog("Filtrar por Disciplina");
      },
    );
  }

  void _filterByPublic(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LeaderboardFilterDialog("Filtrar por Público");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;

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
                      onPressed: () {
                        _filterByDate(context);
                      },
                      isBold: false,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ThemedFilledButton(
                      label: "Disciplina",
                      leadingIcon: const Icon(Icons.menu_book),
                      onPressed: () {
                        _filterBySubject(context);
                      },
                      isBold: false,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ThemedFilledButton(
                      label: "Público",
                      leadingIcon: const Icon(Icons.public),
                      onPressed: () {
                        _filterByPublic(context);
                      },
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
              Text.rich(
                TextSpan(
                  text: "Sua pontuação: ",
                  style: body,
                  children: [
                    TextSpan(
                      text: "$_pontos", // Custom style for this part
                      style: h4.copyWith(color: secondary),
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
