// ignore_for_file: use_build_context_synchronously

import 'package:flashcard_pets/dialogs/confirm_delete_dialog.dart';
import 'package:flashcard_pets/models/flashcard.dart';
import 'package:flashcard_pets/providers/dao/flashcard_dao.dart';
import 'package:flashcard_pets/providers/dao/media_dao.dart';
import 'package:flashcard_pets/screens/card_form_screen.dart';
import 'package:flashcard_pets/screens/preview_card_screen.dart';
import 'package:flashcard_pets/snackbars/error_snackbar.dart';
import 'package:flashcard_pets/snackbars/success_snackbar.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum CardActions {
  editCard,
  deleteCard,
}

class FlashcardCard extends StatefulWidget {
  final Flashcard flashcard;

  const FlashcardCard(this.flashcard, {super.key});

  @override
  State<FlashcardCard> createState() => _FlashcardCardState();
}

class _FlashcardCardState extends State<FlashcardCard> {
  void _previewCard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewCardScreen(widget.flashcard),
      ),
    );
  }

  Future<void> _deleteCard(BuildContext context) async {
    final bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const ConfirmDeleteDialog(
          "Deletar Cartão?",
          "Tem certeza? Essa ação não pode ser desfeita.",
        );
      },
    );

    if (shouldDelete != null && shouldDelete && mounted) {
      try {
        await Provider.of<FlashcardDao>(context, listen: false)
            .delete(widget.flashcard.id);

        final MediaDao mediaDao = Provider.of<MediaDao>(context, listen: false);
        for (int i = 0; i < widget.flashcard.audioFiles.length; i++) {
          await mediaDao.delete(widget.flashcard.audioFiles[i]);
        }
        for (int i = 0; i < widget.flashcard.imgFiles.length; i++) {
          await mediaDao.delete(widget.flashcard.imgFiles[i]);
        }

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
              content:
                  const ErrorSnackbar("Ocorreu algum erro. Tente novamente."),
              backgroundColor: Theme.of(context).colorScheme.bright,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }

  void _editCard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardFormScreen(
                editingFlashcard: widget.flashcard,
              )),
    );
  }

  int daysUntil(DateTime targetDate) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final Duration difference = targetDate.difference(today);
    return difference.isNegative ? 0 : difference.inDays;
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
                    widget.flashcard.frontContent,
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
                    widget.flashcard.backContent,
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
                        "${daysUntil(widget.flashcard.revisionDate)} dias",
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
                        "${widget.flashcard.audioFiles.length + widget.flashcard.imgFiles.length} anexos",
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
