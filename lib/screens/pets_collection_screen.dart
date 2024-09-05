import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/pet_card.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';

class PetsCollectionScreen extends StatelessWidget {
  //Mocked data
  final List<int> _collections = [1];
  PetsCollectionScreen({super.key});

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
                    "Você ainda não possui nenhum pet. Clique no ícone de compras no canto inferior direito da tela para comprar um pet.")
                : ListView.builder(
                    itemCount: _collections.length,
                    itemBuilder: (context, index) {
                      return const PetCard();
                    },
                  ),
          ),
        ],
      ),
    );
  }
}