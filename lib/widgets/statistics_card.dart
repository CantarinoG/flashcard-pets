import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class StatisticsCard extends StatelessWidget {
  //Mocked data:
  final String _title = "Sequência mais longa de revisõe diárias";
  final int _value = 13;
  final String _unit = "dias";
  final IconData _icon = Icons.local_fire_department;
  const StatisticsCard({super.key});

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
              _title,
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
                  "$_value ",
                  style: h1,
                ),
                Text(
                  _unit,
                  style: body,
                ),
                const SizedBox(
                  width: 8,
                ),
                Icon(
                  _icon,
                  color: secondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
