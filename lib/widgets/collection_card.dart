import 'package:flashcard_pets/data_providers/i_data_provider.dart';
import 'package:flashcard_pets/dialogs/confirm_delete_dialog.dart';
import 'package:flashcard_pets/models/subject.dart';
import 'package:flashcard_pets/screens/collection_cards_screen.dart';
import 'package:flashcard_pets/screens/collection_form_screen.dart';
import 'package:flashcard_pets/screens/review_screen.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

enum CollectionAction {
  manageCards,
  editCollection,
  deleteCollection,
}

class CollectionCard extends StatelessWidget {
  //Mocked data.
  final String _title = "Trigonometria";
  final int _cardsNumber = 26;
  final int _reviewsToday = 12;
  final int _subjectCode = 9;

  const CollectionCard({super.key});

  void _manageCards(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CollectionCardsScreen(),
      ),
    );
  }

  void _editCollection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CollectionFormScreen(),
      ),
    );
  }

  void _deleteCollection(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const ConfirmDeleteDialog(
          "Deletar Conjunto?",
          "Tem certeza? Todos os cartões do conjunto também serão deletados. Essa ação não pode ser desfeita.",
        );
      },
    ).then((shouldDelete) {
      //Handle delete logic here
    });
  }

  void _reviewCollection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle h3em = Theme.of(context).textTheme.headlineSmallEm;
    final Color bright = Theme.of(context).colorScheme.bright;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color disabled = Theme.of(context).colorScheme.disabled;

    final Map<int, Subject> subjects =
        Provider.of<IDataProvider<Subject>>(context).retrieveData();

    return Card(
      elevation: 4,
      color: bright,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _reviewCollection(context);
        },
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
                  subjects[_subjectCode]!.iconPath,
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
                              _title,
                              style: h3?.copyWith(
                                color: secondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Text(
                            " ($_cardsNumber)",
                            style: h3?.copyWith(color: secondary),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          style: (_reviewsToday == 0)
                              ? body?.copyWith(color: disabled)
                              : body,
                          children: [
                            TextSpan(
                              text: "$_reviewsToday",
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
                color: bright,
                onSelected: (CollectionAction result) {
                  switch (result) {
                    case CollectionAction.manageCards:
                      _manageCards(context);
                      break;
                    case CollectionAction.editCollection:
                      _editCollection(context);
                      break;
                    case CollectionAction.deleteCollection:
                      _deleteCollection(context);
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
      ),
    );
  }
}
