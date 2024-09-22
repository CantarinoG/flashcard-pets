import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StoreCard extends StatelessWidget {
  //Mocked data
  final _isLocked = true;

  final String name;
  final String desc;
  final String imgPath;
  final int price;
  final int unlockLevel;
  final void Function() onBuy;
  const StoreCard(
    this.name,
    this.desc,
    this.imgPath,
    this.price,
    this.unlockLevel, {
    required this.onBuy,
    super.key,
  });

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
              child: Image.asset(imgPath),
            ),
            Text(
              name,
              style: h2?.copyWith(
                color: secondary,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              desc,
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
                  "$price",
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
                "Libera no nível $unlockLevel",
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
