import 'package:flashcard_pets/widgets/collection_card.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';

class CollectionsMainScreen extends StatelessWidget {
  //Mocked data
  final List<int> _collections = [1, 2, 3];
  CollectionsMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const UserStatsHeader(),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: _collections.isEmpty
                ? const NoItemsPlaceholder(
                    "Você ainda não possui conjuntos. Clique em \"+\" no canto inferior direito da tela para adicionar um conjunto.")
                : ListView.builder(
                    itemCount: _collections.length,
                    itemBuilder: (context, index) {
                      return const CollectionCard();
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
