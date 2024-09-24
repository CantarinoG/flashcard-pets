import 'package:flashcard_pets/screens/pet_screen.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/stars.dart';
import 'package:flutter/material.dart';

class PetCard extends StatelessWidget {
  //Mocked data.
  final String _imgPath = "assets/images/baby_pets/beagle.png";
  final String _name = "Cleitinho";
  final String _breed = "Beagle";
  final String _rarity = "Comum";
  final int _level = 3;
  final String _skillShort = "+2% ouro";

  const PetCard({super.key});

  void _tapPetCard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PetScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? headLineMedium =
        Theme.of(context).textTheme.headlineMedium;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle headLineSmallEm =
        Theme.of(context).textTheme.headlineSmallEm;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color brightColor = Theme.of(context).colorScheme.bright;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color disabled = Theme.of(context).colorScheme.disabled;
    final Color text = Theme.of(context).colorScheme.text;

    return Card(
      elevation: 4,
      color: brightColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _tapPetCard(context);
        },
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 2,
              child: Card(
                color: brightColor,
                margin: const EdgeInsets.all(0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                  ),
                ),
                elevation: 4,
                child: Image.asset(
                  _imgPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              _name,
              style: headLineMedium?.copyWith(
                color: secondary,
              ),
            ),
            Text(
              _breed,
              style: body?.copyWith(
                color: disabled,
              ),
            ),
            const Stars(),
            const SizedBox(
              height: 8,
            ),
            RichText(
              text: TextSpan(
                text: "Lvl ",
                style: headLineSmallEm.copyWith(
                  color: secondary,
                ),
                children: [
                  TextSpan(
                    text: "$_level",
                    style: body,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.diamond,
                  color: secondary,
                ),
                Text(
                  " $_rarity",
                  style: bodyEm.copyWith(color: text),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: secondary,
                ),
                Text(
                  " $_skillShort",
                  style: body,
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }
}
