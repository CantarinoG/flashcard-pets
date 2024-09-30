import 'package:flashcard_pets/dialogs/card_or_collection_dialog.dart';
import 'package:flashcard_pets/main.dart';
import 'package:flashcard_pets/models/collection.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/dao/collection_dao.dart';
import 'package:flashcard_pets/providers/services/user_json_data_provider.dart';
import 'package:flashcard_pets/screens/card_form_screen.dart';
import 'package:flashcard_pets/screens/collection_form_screen.dart';
import 'package:flashcard_pets/widgets/collection_card.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_fab.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionsMainScreen extends StatelessWidget {
  const CollectionsMainScreen({super.key});

  void _toggleTheme(BuildContext context) async {
    final User? user =
        await Provider.of<UserJsonDataProvider>(context).readData();
    if (user == null) return;
    MyApp.of(context)
        .changeTheme(user.darkMode ? ThemeMode.dark : ThemeMode.light);
  }

  void _updateUserStreak(BuildContext context) async {
    final UserJsonDataProvider provider =
        Provider.of<UserJsonDataProvider>(context, listen: false);
    final User? user = await provider.readData();
    if (user == null) return;

    final DateTime? lastOpened = user.lastTimeUsedApp;
    if (lastOpened == null) {
      user.lastTimeUsedApp = DateTime.now();
      await provider.writeData(user);
    } else if (user.dayCreated == null) {
      user.dayCreated = DateTime.now();
      await provider.writeData(user);
    } else {
      final DateTime now = DateTime.now();
      final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
      final bool openedYesterday = lastOpened.year == yesterday.year &&
          lastOpened.month == yesterday.month &&
          lastOpened.day == yesterday.day;
      final bool openedBeforeYesterday = lastOpened.isBefore(yesterday);
      if (openedYesterday) {
        user.streak++;
        if (user.streak > user.highestStreak) {
          user.highestStreak = user.streak;
        }
        user.lastTimeUsedApp = now;
        await provider.writeData(user);
      }
      if (openedBeforeYesterday) {
        user.streak = 0;
        user.lastTimeUsedApp = now;
        await provider.writeData(user);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final collectionDao = Provider.of<CollectionDao>(context);

    debugPrint("rebuild");
    _toggleTheme(context);
    _updateUserStreak(context);

    return FutureBuilder<List<Collection>>(
      future: collectionDao.readAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.hasError) {
          return NoItemsPlaceholder(
            "Error loading collections: ${snapshot.error}.",
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const NoItemsPlaceholder(
            "Você ainda não possui conjuntos. Clique em \"+\" no canto inferior direito da tela para adicionar um conjunto.",
          );
        } else {
          final collections = snapshot.data!;
          return ScreenLayout(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const UserStatsHeader(),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: collections.length,
                    itemBuilder: (context, index) {
                      return CollectionCard(
                        collections[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
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
  const CollectionMainFab({super.key});

  @override
  State<CollectionMainFab> createState() => _CollectionMainFabState();
}

class _CollectionMainFabState extends State<CollectionMainFab> {
  void _onTap() async {
    final collectionDao = Provider.of<CollectionDao>(context, listen: false);
    final collections = await collectionDao.readAll();

    if (collections.isEmpty) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CollectionFormScreen(),
          ),
        );
      }
    } else {
      if (!mounted) return;
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
