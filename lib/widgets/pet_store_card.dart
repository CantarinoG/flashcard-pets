import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';

class PetStoreCard extends StatelessWidget {
  //Mocked data.
  final String _imgPath = "assets/images/baby_pets/beagle.png";
  final String _breed = "Beagle";
  final bool _knownSkill = true;
  final String? skillShort = "+2% ouro";
  const PetStoreCard({super.key});

  void _buy() {
    //...
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? headLineMedium =
        Theme.of(context).textTheme.headlineMedium;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color brightColor = Theme.of(context).colorScheme.bright;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return Card(
      elevation: 4,
      color: brightColor,
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
            _breed,
            style: headLineMedium?.copyWith(
              color: secondary,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: secondary,
              ),
              Text(
                _knownSkill ? " $skillShort" : " Habilidade Desconhecida",
                style: body,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          ThemedFilledButton(
            label: "Comprar",
            onPressed: _buy,
          ),
          const SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
