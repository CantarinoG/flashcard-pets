import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class StatisticsDisplay extends StatelessWidget {
  final String title;
  final String value;
  final IconData iconData;
  final double width;
  const StatisticsDisplay(this.title, this.value, this.iconData,
      {this.width = 100, super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: secondary,
          ),
          Text(
            title,
            style: body,
            textAlign: TextAlign.center,
          ),
          Text(
            value,
            style: h4.copyWith(color: secondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
