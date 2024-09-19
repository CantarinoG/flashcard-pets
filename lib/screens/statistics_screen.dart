import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/statistics_card.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  //Mocked data
  final List<int> _statsI = [1, 2, 3, 4, 5];
  final List<int> _statsII = [1, 2];
  StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    Widget subScreen(BuildContext context, String title, Widget listView) {
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

    return Scaffold(
      appBar: const ThemedAppBar("Estatísticas"),
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
                          subScreen(
                            context,
                            "Cartões e Coleções",
                            ListView.builder(
                              itemCount: _statsI.length,
                              itemBuilder: (context, index) {
                                return const StatisticsCard();
                              },
                            ),
                          ),
                          subScreen(
                            context,
                            "Pets",
                            ListView.builder(
                              itemCount: _statsII.length,
                              itemBuilder: (context, index) {
                                return const StatisticsCard();
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
