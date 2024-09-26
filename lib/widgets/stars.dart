import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  final int starsNumber;
  const Stars(this.starsNumber, {super.key});

  @override
  Widget build(BuildContext context) {
    final Color starColor = Theme.of(context).colorScheme.star;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Padding(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.all(2),
          child: Icon(
            index < starsNumber ? Icons.star : Icons.star_border,
            color: starColor,
          ),
        ),
      ),
    );
  }
}
