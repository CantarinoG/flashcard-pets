import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReviewResultsScreen extends StatelessWidget {
  final String collectionName;
  final int numCards;
  //Mocked data
  final int _totalGold = 234;
  final int _totalExp = 234;
  const ReviewResultsScreen(this.collectionName, this.numCards, {super.key});

  void _finishRevision(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: ThemedAppBar(collectionName),
      body: ScreenLayout(
        child: Column(
          children: [
            const UserStatsHeader(),
            const SizedBox(
              height: 16,
            ),
            Text(
              "$numCards/$numCards",
              style: h2?.copyWith(
                color: secondary,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 173),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Parabéns! Você revisou todos os cartões de $collectionName para essa sessão!",
                        style: body,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Ganhos totais:",
                        style: body,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/custom_icons/coin.svg",
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "$_totalGold",
                            style: body,
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                          Text(
                            "XP",
                            style: h4.copyWith(
                              color: secondary,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "$_totalExp",
                            style: body,
                          ),
                        ],
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.7,
                        child:
                            Image.asset('assets/images/finished_revision.png'),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ThemedFilledButton(
                        label: "Retornar",
                        onPressed: () {
                          _finishRevision(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
