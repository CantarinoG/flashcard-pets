import 'package:flashcard_pets/screens/pet_screen.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class PetCard extends StatelessWidget {
  //Mocked data.
  final String imgPath = "assets/images/baby_pets/beagle.png";
  final String name = "Cleitinho";
  final String breed = "Beagle";
  final int level = 3;
  final String skillShort = "+2% ouro";

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
    Color brightColor = Theme.of(context).colorScheme.bright;
    Color secondary = Theme.of(context).colorScheme.secondary;
    Color disabled = Theme.of(context).colorScheme.disabled;
    TextStyle? headLineSmallEm = Theme.of(context).textTheme.headlineSmallEm;
    TextStyle? headLineMedium = Theme.of(context).textTheme.headlineMedium;
    TextStyle? body = Theme.of(context).textTheme.bodySmall;

    return Card(
      elevation: 4,
      color: brightColor,
      child: InkWell(
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
                  imgPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              name,
              style: headLineMedium?.copyWith(
                color: secondary,
              ),
            ),
            Text(
              breed,
              style: body?.copyWith(
                color: disabled,
              ),
            ),
            RichText(
              text: TextSpan(
                text: "Lvl ",
                style: headLineSmallEm.copyWith(
                  color: secondary,
                ),
                children: [
                  TextSpan(
                    text: "$level",
                    style: body,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: secondary,
                ),
                Text(
                  " $skillShort",
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
