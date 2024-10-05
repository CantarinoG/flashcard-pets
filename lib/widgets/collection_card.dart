// ignore_for_file: use_build_context_synchronously

import 'package:flashcard_pets/dialogs/confirm_delete_dialog.dart';
import 'package:flashcard_pets/models/collection.dart';
import 'package:flashcard_pets/models/flashcard.dart';
import 'package:flashcard_pets/models/subject.dart';
import 'package:flashcard_pets/providers/constants/subject_data_provider.dart';
import 'package:flashcard_pets/providers/dao/collection_dao.dart';
import 'package:flashcard_pets/providers/dao/flashcard_dao.dart';
import 'package:flashcard_pets/providers/dao/media_dao.dart';
import 'package:flashcard_pets/screens/collection_cards_screen.dart';
import 'package:flashcard_pets/screens/collection_form_screen.dart';
import 'package:flashcard_pets/screens/review_screen.dart';
import 'package:flashcard_pets/snackbars/error_snackbar.dart';
import 'package:flashcard_pets/snackbars/info_snackbar.dart';
import 'package:flashcard_pets/snackbars/success_snackbar.dart';
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

class CollectionCard extends StatefulWidget {
  final Collection collection;

  const CollectionCard(this.collection, {super.key});

  @override
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard> {
  void _manageCards(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CollectionCardsScreen(widget.collection),
      ),
    );
  }

  void _editCollection(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CollectionFormScreen(
          editingCollection: widget.collection,
        ),
      ),
    );
  }

  Future<void> _deleteCollection(BuildContext context) async {
    final bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const ConfirmDeleteDialog(
          "Deletar Conjunto?",
          "Tem certeza? Todos os cartões do conjunto também serão deletados. Essa ação não pode ser desfeita.",
        );
      },
    );

    if (shouldDelete != null && shouldDelete && mounted) {
      try {
        final MediaDao mediaDao = Provider.of<MediaDao>(context, listen: false);
        final List<Flashcard> cardsList =
            await Provider.of<FlashcardDao>(context, listen: false)
                .customRead("collectionId = ?", [widget.collection.id]);
        for (int i = 0; i < cardsList.length; i++) {
          for (int j = 0; j < cardsList[i].audioFiles.length; j++) {
            mediaDao.delete(cardsList[i].audioFiles[j]);
          }
          for (int j = 0; j < cardsList[i].imgFiles.length; j++) {
            mediaDao.delete(cardsList[i].imgFiles[j]);
          }
        }

        await Provider.of<FlashcardDao>(context, listen: false)
            .customDelete("collectionId = ?", [widget.collection.id]);

        if (!mounted) return;

        await Provider.of<CollectionDao>(context, listen: false)
            .delete(widget.collection.id);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const SuccessSnackbar("Deletado com sucesso!"),
              backgroundColor: Theme.of(context).colorScheme.bright,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const ErrorSnackbar(
                  "Ocorreu um erro ao deletar. Tente novamente."),
              backgroundColor: Theme.of(context).colorScheme.bright,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }

  void _reviewCollection(BuildContext context, List<Flashcard> toReviewToday) {
    if (toReviewToday.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const InfoSnackbar(
              "Nenhum cartão para revisar nesse conjunto hoje."),
          backgroundColor: Theme.of(context).colorScheme.bright,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewScreen(widget.collection, toReviewToday),
      ),
    );
  }

  List<Flashcard> _filterToBeReviewed(List<Flashcard> list) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return list.where((flashcard) {
      final reviewDate = flashcard.revisionDate;
      return reviewDate.isBefore(today) || reviewDate.isAtSameMomentAs(today);
    }).toList();
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
        Provider.of<SubjectDataProvider>(context).retrieveData();

    final flashcardDao = Provider.of<FlashcardDao>(context);

    return Card(
      elevation: 4,
      color: bright,
      child: SizedBox(
        height: 80,
        child: FutureBuilder<List<Flashcard>>(
          future: flashcardDao.customRead(
            "collectionId = ?",
            [widget.collection.id],
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }

            if (snapshot.hasError) {
              return const Center(
                  child:
                      Text("Algo errado ocorreu. Tente novamente mais tarde."));
            }

            if (!snapshot.hasData) {
              return const Center(
                  child:
                      Text("Algo errado ocorreu. Tente novamente mais tarde."));
            }

            final List<Flashcard> cards = snapshot.data ?? [];
            final int cardsNumber = cards.length;
            final List<Flashcard> toReviewToday = _filterToBeReviewed(cards);
            final int numToReviewToday = toReviewToday.length;

            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                _reviewCollection(context, toReviewToday);
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
                        subjects[widget.collection.subjectCode]!.iconPath,
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
                                    widget.collection.name,
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
                                style: (numToReviewToday == 0)
                                    ? body?.copyWith(color: disabled)
                                    : body,
                                children: [
                                  TextSpan(
                                    text: "$numToReviewToday",
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
            );
          },
        ),
      ),
    );
  }
}
