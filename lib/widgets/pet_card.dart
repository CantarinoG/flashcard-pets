import 'package:flashcard_pets/models/pet.dart';
import 'package:flashcard_pets/providers/constants/pet_bio_data_provider.dart';
import 'package:flashcard_pets/providers/services/standard_game_elements_calculations.dart';
import 'package:flashcard_pets/screens/pet_screen.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/rarity_text.dart';
import 'package:flashcard_pets/widgets/stars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PetCard extends StatelessWidget {
  final Pet pet;

  const PetCard(this.pet, {super.key});

  void _tapPetCard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PetScreen(pet),
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
    final Color brightColor = Theme.of(context).colorScheme.bright;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color disabled = Theme.of(context).colorScheme.disabled;

    final petBio = Provider.of<PetBioDataProvider>(context)
        .retrieveFromKey(pet.petBioCode);
    final gameElementCalcProvider =
        Provider.of<StandardGameElementsCalculations>(context);
    final double petBonusValue =
        gameElementCalcProvider.calculatePetBonus(pet, petBio.rarity);
    final String petBonusDescription =
        "+${((petBonusValue - 1) * 100).round()}% ${gameElementCalcProvider.petSkillToString(petBio.skill)}";

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
                  (pet.level < 10) ? petBio.babyPic : petBio.adultPic,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              pet.name ?? petBio.breed,
              style: headLineMedium?.copyWith(
                color: secondary,
              ),
            ),
            Text(
              petBio.breed,
              style: body?.copyWith(
                color: disabled,
              ),
            ),
            Stars(pet.stars),
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
                    text: "${pet.level}",
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
                RarityText(petBio.rarity),
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
                  " $petBonusDescription",
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
