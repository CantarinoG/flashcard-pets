import 'package:flashcard_pets/dialogs/leaderboard_filter_dialog.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/services/user_json_data_provider.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/widgets/leaderboard_user_card.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flashcard_pets/providers/services/firebase_social_provider.dart';

class LeaderboardSubscreen extends StatelessWidget {
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

    return FutureBuilder<Map<String, dynamic>>(
      future: Future.wait([
        Provider.of<FirebaseSocialProvider>(context, listen: false)
            .getTop10GlobalUsers(),
        Provider.of<UserJsonDataProvider>(context, listen: false).readData(),
      ]).then((results) => {
            'top10Users': results[0] as List<Map<String, dynamic>>,
            'userData': results[1] as User,
          }),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot);
          return const NoItemsPlaceholder(
              "Ocorreu um erro ao carregar o placar. Tente novamente mais tarde.");
        } else if (!snapshot.hasData ||
            (snapshot.data!['top10Users'] as List).isEmpty) {
          return const NoItemsPlaceholder(
              "Não há usuários no placar no momento. Tente novamente mais tarde.");
        }

        final List<Map<String, dynamic>> users =
            snapshot.data!['top10Users'] as List<Map<String, dynamic>>;
        final User userData = snapshot.data!['userData'] as User;

        return Column(
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
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return LeaderboardUserCard(
                    ranking: index + 1,
                    avatarCode: user['avatarCode'],
                    bgColorCode: user['bgColorCode'],
                    name: user['name'],
                    id: user['id'],
                    totalXp: user['totalXp'],
                  );
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
                    text:
                        "${userData.totalXp}", // Use user's actual XP if available
                    style: h4.copyWith(color: secondary),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
