import 'package:flashcard_pets/models/pet_bio.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/rarity_text.dart';
import 'package:flutter/material.dart';

class PetDescriptionCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String content;
  final Color? color;
  final PetRarity? rarity;

  const PetDescriptionCard(
      {required this.iconData,
      required this.title,
      required this.content,
      this.color,
      this.rarity,
      super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color bright = Theme.of(context).colorScheme.bright;

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        color: bright,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconData,
                    color: secondary,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    title,
                    style: h3?.copyWith(
                      color: secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              (rarity != null)
                  ? RarityText(rarity!)
                  : Text(
                      content,
                      style: body,
                      textAlign: TextAlign.center,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
