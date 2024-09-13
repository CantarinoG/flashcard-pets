import 'package:flashcard_pets/widgets/flashcard_card.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_fab.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';

class CollectionCardsScreen extends StatelessWidget {
  //Mocked data
  final String _title = "Cálculo I";
  final List<int> _cards = [1, 1, 1, 1];
  CollectionCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar("$_title (${_cards.length})"),
      floatingActionButton: ThemedFab(() {}, const Icon(Icons.add)),
      body: ScreenLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const UserStatsHeader(),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: _cards.isEmpty
                  ? const NoItemsPlaceholder(
                      "Você ainda não possui cartões nesse conjunto. Clique em “+” no canto inferior direito da tela para adicionar um cartão.")
                  : ListView.builder(
                      itemCount: _cards.length,
                      itemBuilder: (context, index) {
                        return const FlashcardCard();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}