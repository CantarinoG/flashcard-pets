import 'package:flashcard_pets/widgets/award_card.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';

class AwardsScreen extends StatelessWidget {
  //Mocked data
  final int totalUserReviews = 100;
  final int userConsecutiveDays = 24;
  final int totalUserMaxScoreReviews = 78;
  final int totalUserRegisteredCards = 430;
  final int totalUserPets = 9;
  final int highestPetLevel = 23;
  final int highestPetStar = 2;
  final int totalUserFriens = 234;
  final int totalGiftsSent = 34;
  final int isInRanking = 0;
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
                length: 3,
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
                        Tab(
                            icon: Icon(
                          Icons.diversity_3,
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
                          _subScreen(
                            context,
                            "Social",
                            ListView(
                              children: [
                                AwardCard(21, totalUserFriens),
                                AwardCard(22, totalUserFriens),
                                AwardCard(23, totalUserFriens),
                                AwardCard(24, totalGiftsSent),
                                AwardCard(25, totalGiftsSent),
                                AwardCard(26, totalGiftsSent),
                                AwardCard(27, isInRanking),
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
  }
}
