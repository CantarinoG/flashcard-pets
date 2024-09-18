import 'package:flashcard_pets/widgets/pet_store_card.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  //Mocked data
  final List<int> _pets = [1, 2, 3];
  StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemedAppBar("Loja"),
      body: ScreenLayout(
        child: Column(
          children: [
            const UserStatsHeader(),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _pets.length,
                itemBuilder: (context, index) {
                  return const PetStoreCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
