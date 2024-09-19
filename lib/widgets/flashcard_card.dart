import 'package:flashcard_pets/screens/review_screen.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

enum CardActions {
  editCard,
  deleteCard,
}

class FlashcardCard extends StatelessWidget {
  //Mocked data
  final String _frontContent = "Como calcular uma derivada?";
  final String _backContent =
      "Para calcular uma derivada, basta lorem ipsum lorem ipsum lorem ipsum.";
  final int _daysToNextRevision = 8;
  final int _mediaAttachedNum = 2;
  const FlashcardCard({super.key});

  void _previewCard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewScreen(),
      ),
    );
  }

  void _deleteCard(BuildContext context) {
    //...
  }

  void _editCard(BuildContext context) {
    //...
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color brightColor = Theme.of(context).colorScheme.bright;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return Card(
      elevation: 4,
      color: brightColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _previewCard(context);
        },
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
                      PopupMenuButton<CardActions>(
                        tooltip: "Ver opções",
                        iconColor: primary,
                        color: brightColor,
                        onSelected: (CardActions result) {
                          switch (result) {
                            case CardActions.editCard:
                              _editCard(context);
                              break;
                            case CardActions.deleteCard:
                              _deleteCard(context);
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<CardActions>>[
                          PopupMenuItem<CardActions>(
                            value: CardActions.editCard,
                            child: Text(
                              'Editar Cartão',
                              style: body,
                            ),
                          ),
                          PopupMenuItem<CardActions>(
                            value: CardActions.deleteCard,
                            child: Text(
                              'Deletar Cartão',
                              style: body,
                            ),
                          ),
                        ],
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
      ),
    );
  }
}
