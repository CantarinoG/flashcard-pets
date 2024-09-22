import 'package:flashcard_pets/widgets/award_card.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';

class AwardsScreen extends StatelessWidget {
  //Mocked data
  final List<int> _awardsFlashcards = [1, 2, 3, 4, 5];
  final List<int> _awardsPets = [1, 2];
  final List<int> _awardsSocial = [1, 2];
  AwardsScreen({super.key});

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
                length: 4,
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
                            ListView.builder(
                              itemCount: _awardsFlashcards.length,
                              itemBuilder: (context, index) {
                                return AwardCard();
                              },
                            ),
                          ),
                          _subScreen(
                            context,
                            "Pets",
                            ListView.builder(
                              itemCount: _awardsPets.length,
                              itemBuilder: (context, index) {
                                return AwardCard();
                              },
                            ),
                          ),
                          _subScreen(
                            context,
                            "Social",
                            ListView.builder(
                              itemCount: _awardsSocial.length,
                              itemBuilder: (context, index) {
                                return AwardCard();
                              },
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
