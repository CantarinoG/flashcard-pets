import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StoreCard extends StatelessWidget {
  //Mocked data.
  final String _imgPath = "assets/images/baby_pets/beagle.png";
  final String _name = "Baú Básico";
  final String _desc =
      "Geralmente contém um pet de raridade comum. Pequena chance de conter um pet de raridade incomum.";
  final int _price = 234;
  final int _unlockLevel = 34;
  final bool _isLocked = true;
  const StoreCard({super.key});

  void _buy() {
    //...
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color brightColor = Theme.of(context).colorScheme.bright;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color warn = Theme.of(context).colorScheme.warning;

    return Card(
      elevation: 4,
      color: brightColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        child: Column(
          children: [
            FractionallySizedBox(
              widthFactor: 0.7,
              child: Image.asset(_imgPath),
            ),
            Text(
              _name,
              style: h2?.copyWith(
                color: secondary,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              _desc,
              style: body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "assets/images/custom_icons/coin.svg",
                  width: 30,
                  height: 30,
                ),
                Text(
                  "$_price",
                  style: h3,
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            ThemedFilledButton(
              label: "Comprar",
              onPressed: _isLocked ? null : _buy,
            ),
            if (_isLocked)
              const SizedBox(
                height: 8,
              ),
            if (_isLocked)
              Text(
                "Libera no nível $_unlockLevel",
                style: h3?.copyWith(
                  color: warn,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
