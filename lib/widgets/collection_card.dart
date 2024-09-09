import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CollectionAction {
  manageCards,
  editCollection,
  deleteCollection,
}

class CollectionCard extends StatelessWidget {
  //Mocked data.
  final String title = "Trigonometria";
  final int cardsNumber = 26;
  final int reviewsToday = 12;
  final String imgPath = "assets/images/icons/math.svg";

  const CollectionCard({super.key});

  void _manageCards() {
    // Logic for managing cards
  }

  void _editCollection() {
    // Logic for editing the collection
  }

  void _deleteCollection() {
    // Logic for deleting the collection
  }

  @override
  Widget build(BuildContext context) {
    Color brightColor = Theme.of(context).colorScheme.bright;
    Color primary = Theme.of(context).colorScheme.primary;
    Color secondary = Theme.of(context).colorScheme.secondary;
    Color disabled = Theme.of(context).colorScheme.disabled;

    TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    TextStyle? h3em = Theme.of(context).textTheme.headlineSmallEm;
    TextStyle? body = Theme.of(context).textTheme.bodySmall;

    return Card(
      elevation: 4,
      color: brightColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: SvgPicture.asset(
                imgPath,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: h3?.copyWith(
                              color: secondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Text(
                          " ($cardsNumber)",
                          style: h3?.copyWith(color: secondary),
                        ),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        style: (reviewsToday == 0)
                            ? body?.copyWith(color: disabled)
                            : body,
                        children: [
                          TextSpan(
                            text: "$reviewsToday",
                            style: h3em,
                          ),
                          const TextSpan(
                            text: " Para revisão",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PopupMenuButton<CollectionAction>(
              tooltip: "Ver opções",
              iconColor: primary,
              color: brightColor,
              onSelected: (CollectionAction result) {
                switch (result) {
                  case CollectionAction.manageCards:
                    _manageCards();
                    break;
                  case CollectionAction.editCollection:
                    _editCollection();
                    break;
                  case CollectionAction.deleteCollection:
                    _deleteCollection();
                    break;
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<CollectionAction>>[
                PopupMenuItem<CollectionAction>(
                  value: CollectionAction.manageCards,
                  child: Text(
                    'Gerenciar Cartões',
                    style: body,
                  ),
                ),
                PopupMenuItem<CollectionAction>(
                  value: CollectionAction.editCollection,
                  child: Text(
                    'Editar Conjunto',
                    style: body,
                  ),
                ),
                PopupMenuItem<CollectionAction>(
                  value: CollectionAction.deleteCollection,
                  child: Text(
                    'Deletar Conjunto',
                    style: body,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
