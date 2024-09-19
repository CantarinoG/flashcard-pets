import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class AwardCardBasic extends StatelessWidget {
  //Mocked data
  final String _imgPath = "assets/images/baby_pets/beagle.png";
  final String _awardName = "Mestre I";
  const AwardCardBasic({super.key});

  @override
  Widget build(BuildContext context) {
    Color brightColor = Theme.of(context).colorScheme.bright;
    Color secondary = Theme.of(context).colorScheme.secondary;
    TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;

    return Card(
      elevation: 4,
      color: brightColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              _imgPath,
              width: 60,
              height: 60,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              _awardName,
              style: bodyEm.copyWith(
                color: secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
