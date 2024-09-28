import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/statistics_card.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  //Mocked data
  final int _retrievedValue = 5;
  const StatisticsScreen({super.key});

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
                            ListView(
                              children: [
                                StatisticsCard(
                                  "Total de Revisões",
                                  _retrievedValue,
                                  "revisões",
                                ),
                                StatisticsCard(
                                  "Taxa de Acerto",
                                  _retrievedValue,
                                  "%",
                                ),
                                StatisticsCard(
                                  "Sequência Mais Longa de Revisões Diárias",
                                  _retrievedValue,
                                  "dias",
                                ),
                                StatisticsCard(
                                  "Tempo Total de Revisão",
                                  _retrievedValue,
                                  "segundos",
                                ),
                                StatisticsCard(
                                  "Média de Revisões Diárias",
                                  _retrievedValue,
                                  "revisões/dia",
                                ),
                                StatisticsCard(
                                  "Número de Coleções Registradas",
                                  _retrievedValue,
                                  "coleções",
                                ),
                                StatisticsCard(
                                  "Número de Cartões Registrados",
                                  _retrievedValue,
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
                                  _retrievedValue,
                                  "unidades",
                                ),
                                StatisticsCard(
                                  "Ouro Gasto",
                                  _retrievedValue,
                                  "unidades",
                                ),
                                StatisticsCard(
                                  "Pontos de Experiências Obtidos",
                                  _retrievedValue,
                                  "pontos",
                                ),
                                StatisticsCard(
                                  "Pets Obtidos",
                                  _retrievedValue,
                                  "pets",
                                ),
                                StatisticsCard(
                                  "Aumento de Nível em Pets",
                                  _retrievedValue,
                                  "níveis",
                                ),
                                StatisticsCard(
                                  "Média de Ouro/Pontos de Experiência por Revisão",
                                  _retrievedValue,
                                  "unidades/pontos",
                                ),
                                StatisticsCard(
                                  "Amigos Adicionados",
                                  _retrievedValue,
                                  "amigos",
                                ),
                                StatisticsCard(
                                  "Presentes Enviados",
                                  _retrievedValue,
                                  "presentes",
                                ),
                                StatisticsCard(
                                  "Presentes Recebidos",
                                  _retrievedValue,
                                  "presentes",
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
        ),
      ),
    );
  }
}
