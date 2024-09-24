import 'package:flashcard_pets/models/award.dart';
import 'package:flashcard_pets/providers/constants/i_data_provider.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AwardCardBasic extends StatelessWidget {
  final int awardId;

  const AwardCardBasic(this.awardId, {super.key});

  @override
  Widget build(BuildContext context) {
    Color brightColor = Theme.of(context).colorScheme.bright;
    Color secondary = Theme.of(context).colorScheme.secondary;
    TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;

    final Award award =
        Provider.of<IDataProvider<Award>>(context).retrieveFromKey(awardId);

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
              award.iconPath,
              width: 60,
              height: 60,
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              height: 40,
              child: Text(
                award.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: bodyEm.copyWith(
                  color: secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
