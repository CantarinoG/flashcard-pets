import 'package:flashcard_pets/models/pet_bio.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class RarityText extends StatelessWidget {
  final PetRarity rarity;
  const RarityText(this.rarity, {super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color text = Theme.of(context).colorScheme.text;

    final Map<PetRarity, Widget> widget = {
      PetRarity.common: Text(
        "Comum",
        style: bodyEm.copyWith(color: text),
      ),
      PetRarity.uncommon: Text(
        "Incomum",
        style: bodyEm.copyWith(color: const Color.fromARGB(255, 74, 94, 150)),
      ),
      PetRarity.rare: Text(
        "Raro",
        style: bodyEm.copyWith(color: const Color.fromARGB(255, 114, 68, 141)),
      ),
      PetRarity.epic: Text(
        "Épico",
        style: bodyEm.copyWith(color: const Color.fromARGB(255, 129, 91, 60)),
      ),
    };

    return widget[rarity]!;
  }
}
