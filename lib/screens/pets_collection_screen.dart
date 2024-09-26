import 'package:flashcard_pets/models/pet.dart';
import 'package:flashcard_pets/providers/dao/i_dao.dart';
import 'package:flashcard_pets/screens/store_screen.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/pet_card.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_fab.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PetsCollectionScreen extends StatelessWidget {
  const PetsCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final petDao = Provider.of<IDao<Pet>>(context);

    return ScreenLayout(
      child: FutureBuilder<List<Pet>>(
        future: petDao.readAll(), // The Future you want to resolve
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return const NoItemsPlaceholder(
                "Algum erro ocorreu. Tente novamente mais tarde.");
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const NoItemsPlaceholder(
              "Você ainda não possui nenhum pet. Clique no ícone de compras no canto inferior direito da tela para comprar um pet.",
            );
          } else {
            final petList = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const UserStatsHeader(),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: petList.length,
                    itemBuilder: (context, index) {
                      final pet = petList[index];
                      return PetCard(pet); // Passing pet to PetCard
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class PetsCollectionAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PetsCollectionAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return const ThemedAppBar(
      "Pets",
    );
  }
}

class PetsCollectionFab extends StatelessWidget {
  const PetsCollectionFab({super.key});

  void _onTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StoreScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemedFab(
      () {
        _onTap(context);
      },
      const Icon(Icons.shopping_bag),
    );
  }
}
