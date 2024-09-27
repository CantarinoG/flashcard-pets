import 'package:flashcard_pets/models/pet.dart';
import 'package:flashcard_pets/models/pet_bio.dart';
import 'package:flashcard_pets/providers/constants/i_data_provider.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PetLevelupSnackbar extends StatelessWidget {
  final Pet pet;
  final bool isLevelUp;
  const PetLevelupSnackbar(this.pet, this.isLevelUp, {super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle? h1 = Theme.of(context).textTheme.headlineLarge;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color star = Theme.of(context).colorScheme.star;

    final PetBio petBio = Provider.of<IDataProvider<PetBio>>(context)
        .retrieveFromKey(pet.petBioCode);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Image.asset(
            petBio.adultPic,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          isLevelUp
              ? "${pet.name ?? petBio.breed} subiu de nível!"
              : "${pet.name ?? petBio.breed} ganhou mais uma estrela!",
          style: body?.copyWith(
            color: primary,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isLevelUp
                ? Text(
                    "Lvl",
                    style: h4.copyWith(color: secondary),
                  )
                : Icon(
                    Icons.star,
                    color: star,
                    size: h4.fontSize,
                  ),
            Text(
              isLevelUp ? "${pet.level}" : " ${pet.stars}",
              style: h1?.copyWith(color: secondary),
            ),
          ],
        ),
      ],
    );
  }
}
