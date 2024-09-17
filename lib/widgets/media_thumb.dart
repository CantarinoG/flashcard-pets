import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class MediaThumb extends StatelessWidget {
  String? imgPath;
  MediaThumb({this.imgPath, super.key});

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color bright = Theme.of(context).colorScheme.bright;

    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(12),
        border: (imgPath == null)
            ? null
            : Border.all(
                color: primary,
                width: 2,
              ),
      ),
      child: (imgPath == null)
          ? IconButton(
              icon: const Icon(Icons.mic),
              color: bright,
              onPressed: () {},
            )
          : InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imgPath!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}
