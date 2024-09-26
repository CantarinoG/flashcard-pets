import 'package:flashcard_pets/models/pet_bio.dart';
import 'package:flashcard_pets/providers/constants/i_data_provider.dart';
import 'package:flashcard_pets/widgets/rarity_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PetGotSnackbar extends StatelessWidget {
  final int petBioCode;
  const PetGotSnackbar(this.petBioCode, {super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color primary = Theme.of(context).colorScheme.primary;

    final PetBio petBio =
        Provider.of<IDataProvider<PetBio>>(context).retrieveFromKey(petBioCode);

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
          "Você abriu o baú e encontrou um lindo ${petBio.breed}!",
          style: body?.copyWith(
            color: primary,
          ),
        ),
        RarityText(petBio.rarity),
      ],
    );
  }
}
