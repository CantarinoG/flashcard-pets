import 'package:flashcard_pets/models/collection.dart';
import 'package:flashcard_pets/models/flashcard.dart';
import 'package:flashcard_pets/screens/card_form_screen.dart';
import 'package:flashcard_pets/widgets/flashcard_card.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_fab.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';

class CollectionCardsScreen extends StatelessWidget {
  final Collection collection;
  final List<Flashcard> cards;
  const CollectionCardsScreen(this.collection, this.cards, {super.key});

  void _createNewCard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardFormScreen(
          preSelectedCollectionId: collection.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;

    return Scaffold(
      appBar: ThemedAppBar("${collection.name} (${cards.length})"),
      floatingActionButton: ThemedFab(
        () {
          _createNewCard(context);
        },
        const Icon(Icons.add),
      ),
      body: ScreenLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const UserStatsHeader(),
            const SizedBox(
              height: 16,
            ),
            if (collection.description.isNotEmpty)
              Text(
                collection.description,
                style: body,
              ),
            if (collection.description.isNotEmpty)
              const SizedBox(
                height: 8,
              ),
            Expanded(
              child: cards.isEmpty
                  ? const NoItemsPlaceholder(
                      "Você ainda não possui cartões nesse conjunto. Clique em “+” no canto inferior direito da tela para adicionar um cartão.")
                  : ListView.builder(
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        return FlashcardCard(cards[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
