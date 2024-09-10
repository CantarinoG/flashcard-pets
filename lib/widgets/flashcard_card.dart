import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class FlashcardCard extends StatelessWidget {
  //Mocked data
  final String _frontContent = "Como calcular uma derivada?";
  final String _backContent =
      "Para calcular uma derivada, basta lorem ipsum lorem ipsum lorem ipsum.";
  final int _daysToNextRevision = 8;
  final int _mediaAttachedNum = 2;
  const FlashcardCard({super.key});

  @override
  Widget build(BuildContext context) {
    Color brightColor = Theme.of(context).colorScheme.bright;
    Color primary = Theme.of(context).colorScheme.primary;
    Color secondary = Theme.of(context).colorScheme.secondary;

    TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    TextStyle? body = Theme.of(context).textTheme.bodySmall;

    return Card(
      elevation: 4,
      color: brightColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Frente",
                  style: h3?.copyWith(color: secondary),
                ),
                Text(
                  _frontContent,
                  style: body,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Verso",
                  style: h3?.copyWith(color: secondary),
                ),
                Text(
                  _backContent,
                  style: body,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: secondary,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "$_daysToNextRevision dias",
                      style: body?.copyWith(color: secondary),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.attach_file,
                      color: secondary,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "$_mediaAttachedNum anexos",
                      style: body?.copyWith(color: secondary),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert,
                        color: primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Icon(
                Icons.dashboard,
                color: secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
