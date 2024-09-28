import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class StatisticsCard extends StatelessWidget {
  final String title;
  final num value;
  final String unit;
  const StatisticsCard(this.title, this.value, this.unit, {super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? h1 = Theme.of(context).textTheme.headlineLarge;
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color bright = Theme.of(context).colorScheme.bright;

    return Card(
      elevation: 4,
      color: bright,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: h3?.copyWith(
                color: secondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$value ",
                  style: h1,
                ),
                Text(
                  unit,
                  style: body,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
