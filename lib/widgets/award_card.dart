import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AwardCard extends StatelessWidget {
  //Mocked data
  final String _imgPath = "assets/images/baby_pets/beagle.png";
  final String _title = "Mestre dos Flashcards";
  final String _description = "Revise um total de 100 flashcards.";
  final int _goalScore = 100;
  final int _currentScore = 78;
  late final double _progress = _currentScore / _goalScore;
  final int _goldReward = 234;
  final int _xpReward = 234;
  final bool _isCompleted = false;
  AwardCard({super.key});

  @override
  Widget build(BuildContext context) {
    Color brightColor = Theme.of(context).colorScheme.bright;
    Color primary = Theme.of(context).colorScheme.primary;
    Color secondary = Theme.of(context).colorScheme.secondary;

    TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    TextStyle? h3em = Theme.of(context).textTheme.headlineSmallEm;
    TextStyle? body = Theme.of(context).textTheme.bodySmall;
    TextStyle? bodyEm = Theme.of(context).textTheme.bodySmallEm;

    return Card(
      elevation: 4,
      color: brightColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipOval(
                    child: Image.asset(
                      _imgPath,
                      fit: BoxFit
                          .cover, // Ensures the image fits nicely within the circular shape
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        _title,
                        style: h3?.copyWith(
                          color: secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        _description,
                        style: body,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(colors: [
                    primary,
                    secondary,
                    const Color.fromARGB(255, 201, 201, 201),
                  ], stops: [
                    _progress / 2,
                    _progress,
                    _progress,
                  ])),
              child: const SizedBox(height: 8),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "$_currentScore/$_goalScore",
                style: body?.copyWith(
                  color: secondary,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Recompensa:",
                  style: bodyEm,
                ),
                const Expanded(child: SizedBox()),
                SvgPicture.asset(
                  "assets/images/icons/coin.svg",
                  width: 30,
                  height: 30,
                ),
                Text("$_goldReward"),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "XP ",
                  style: h3em.copyWith(color: secondary),
                ),
                Text("$_xpReward"),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            ThemedFilledButton(
                label: "Resgatar Recompensa",
                onPressed: _isCompleted ? () {} : null),
          ],
        ),
      ),
    );
  }
}
