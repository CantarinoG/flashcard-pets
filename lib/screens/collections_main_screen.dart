import 'package:flashcard_pets/dialogs/card_or_collection_dialog.dart';
import 'package:flashcard_pets/screens/card_form_screen.dart';
import 'package:flashcard_pets/screens/collection_form_screen.dart';
import 'package:flashcard_pets/widgets/collection_card.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_fab.dart';
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

class CollectionMainAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CollectionMainAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return const ThemedAppBar(
      "Flashcards",
    );
  }
}

class CollectionMainFab extends StatefulWidget {
  //Mocked data
  final bool _anyCollections = true;

  const CollectionMainFab({super.key});

  @override
  State<CollectionMainFab> createState() => _CollectionMainFabState();
}

class _CollectionMainFabState extends State<CollectionMainFab> {
  void _onTap() {
    if (!widget._anyCollections) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CollectionFormScreen(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CardOrCollectionDialog();
        },
      ).then((result) {
        if (!mounted) return;
        if (result == CardOrCollectionDialogResult.card) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardFormScreen(),
            ),
          );
        } else if (result == CardOrCollectionDialogResult.collection) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CollectionFormScreen(),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemedFab(
      _onTap,
      const Icon(Icons.add),
    );
  }
}
