import 'package:flashcard_pets/models/pet.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/dao/pet_dao.dart';
import 'package:flashcard_pets/providers/services/user_json_data_provider.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/statistics_card.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    final UserJsonDataProvider userProvider =
        Provider.of<UserJsonDataProvider>(context);
    final PetDao petProvider = Provider.of<PetDao>(context);

    return Scaffold(
      appBar: const ThemedAppBar("Estatísticas"),
      body: ScreenLayout(
        child: FutureBuilder<List<dynamic>>(
          future: Future.wait([
            userProvider.readData(),
            petProvider.readAll(),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            } else if (snapshot.hasError) {
              return NoItemsPlaceholder('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data![0] == null) {
              return const NoItemsPlaceholder('No user data available');
            }

            final user = snapshot.data![0] as User;
            final pets = snapshot.data![1] as List<Pet>;

            return Column(
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
                                ListView(
                                  children: [
                                    StatisticsCard(
                                      "Total de Revisões",
                                      user.totalReviewedCards,
                                      "revisões",
                                    ),
                                    StatisticsCard(
                                      "Taxa de Acerto",
                                      (user.totalRightCardsReviewed /
                                          user.totalReviewedCards *
                                          100),
                                      "%",
                                    ),
                                    StatisticsCard(
                                      "Sequência Atual de Dias Usando o App",
                                      user.streak,
                                      "dias",
                                    ),
                                    StatisticsCard(
                                      "Sequência Mais Longa de Dias Usando o App",
                                      user.highestStreak,
                                      "dias",
                                    ),
                                    StatisticsCard(
                                      "Média de Revisões Diárias",
                                      (user.totalReviewedCards /
                                          (DateTime.now()
                                                  .difference(user.dayCreated!)
                                                  .inDays +
                                              1)),
                                      "revisões/dia",
                                    ),
                                    StatisticsCard(
                                      "Número de Coleções Registradas",
                                      user.createdCollections,
                                      "coleções",
                                    ),
                                    StatisticsCard(
                                      "Número de Cartões Registrados",
                                      user.createdCards,
                                      "cartões",
                                    ),
                                  ],
                                ),
                              ),
                              subScreen(
                                context,
                                "Pets",
                                ListView(
                                  children: [
                                    StatisticsCard(
                                      "Ouro Obtido",
                                      user.totalGoldEarned,
                                      "unidades",
                                    ),
                                    StatisticsCard(
                                      "Ouro Gasto",
                                      user.totalGoldSpent,
                                      "unidades",
                                    ),
                                    StatisticsCard(
                                      "Pontos de Experiências Obtidos",
                                      user.totalXp,
                                      "pontos",
                                    ),
                                    StatisticsCard(
                                      "Pets Obtidos",
                                      pets.length,
                                      "pets",
                                    ),
                                    StatisticsCard(
                                      "Aumento de Nível em Pets",
                                      pets.fold(
                                          0, (sum, pet) => sum + pet.level),
                                      "níveis",
                                    ),
                                    StatisticsCard(
                                      "Média de Ouro por Revisão",
                                      (user.totalGoldFromRevisions /
                                          user.totalReviewedCards),
                                      "unidades",
                                    ),
                                    StatisticsCard(
                                      "Média de Pontos de Experiência por Revisão",
                                      (user.totalXpFromRevisions /
                                          user.totalReviewedCards),
                                      "pontos",
                                    ),
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
            );
          },
        ),
      ),
    );
  }
}
