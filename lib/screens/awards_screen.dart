import 'package:flashcard_pets/models/pet.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/dao/pet_dao.dart';
import 'package:flashcard_pets/providers/services/user_json_data_provider.dart';
import 'package:flashcard_pets/widgets/award_card.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AwardsScreen extends StatelessWidget {
  const AwardsScreen({super.key});

  Widget _subScreen(BuildContext context, String title, Widget listView) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Text(
          title,
          style: h2?.copyWith(
            color: secondary,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: listView,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    final UserJsonDataProvider userProvider =
        Provider.of<UserJsonDataProvider>(context);
    final PetDao petDaoProvider = Provider.of<PetDao>(context);

    return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        userProvider.readData(),
        petDaoProvider.readAll(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else if (snapshot.hasError) {
          return NoItemsPlaceholder('Error: ${snapshot.error}');
        } else if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return const NoItemsPlaceholder('No data available');
        }

        final User user = snapshot.data![0] as User;
        final List<Pet> pets = snapshot.data![1] as List<Pet>;

        final int totalUserReviews = user.totalReviewedCards;
        final int userConsecutiveDays = user.highestStreak;
        final int totalUserMaxScoreReviews = user.totalMaxQualityRevisions;
        final int totalUserRegisteredCards = user.createdCards;

        final int totalUserPets = pets.length;
        final int highestPetLevel = pets.isNotEmpty
            ? pets
                .map((p) => p.level)
                .reduce((max, level) => level > max ? level : max)
            : 0;
        final int highestPetStar = pets.isNotEmpty
            ? pets
                .map((p) => p.stars)
                .reduce((max, stars) => stars > max ? stars : max)
            : 0;

        const int mockedData = 5;

        return Scaffold(
          appBar: const ThemedAppBar("Conquistas"),
          body: ScreenLayout(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const UserStatsHeader(),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: secondary,
                          unselectedLabelColor: primary,
                          labelStyle: h3,
                          unselectedLabelStyle: h3,
                          indicatorColor: secondary,
                          overlayColor: WidgetStateProperty.resolveWith<Color?>(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.hovered)) {
                                return primary.withOpacity(0.05);
                              }
                              if (states.contains(WidgetState.pressed)) {
                                return secondary;
                              }
                              return null;
                            },
                          ),
                          tabs: const [
                            Tab(
                                icon: Icon(
                              Icons.dashboard,
                            )),
                            Tab(
                                icon: Icon(
                              Icons.pets,
                            )),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _subScreen(
                                context,
                                "Cartões e Revisões",
                                ListView(
                                  children: [
                                    AwardCard(0, totalUserReviews),
                                    AwardCard(1, totalUserReviews),
                                    AwardCard(2, totalUserReviews),
                                    AwardCard(3, userConsecutiveDays),
                                    AwardCard(4, userConsecutiveDays),
                                    AwardCard(5, userConsecutiveDays),
                                    AwardCard(6, totalUserMaxScoreReviews),
                                    AwardCard(7, totalUserMaxScoreReviews),
                                    AwardCard(8, totalUserMaxScoreReviews),
                                    AwardCard(9, totalUserRegisteredCards),
                                    AwardCard(10, totalUserRegisteredCards),
                                    AwardCard(11, totalUserRegisteredCards),
                                  ],
                                ),
                              ),
                              _subScreen(
                                context,
                                "Pets",
                                ListView(
                                  children: [
                                    AwardCard(12, totalUserPets),
                                    AwardCard(13, totalUserPets),
                                    AwardCard(14, totalUserPets),
                                    AwardCard(15, highestPetLevel),
                                    AwardCard(16, highestPetLevel),
                                    AwardCard(17, highestPetLevel),
                                    AwardCard(18, highestPetStar),
                                    AwardCard(19, highestPetStar),
                                    AwardCard(20, highestPetStar),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
