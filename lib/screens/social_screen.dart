import 'package:flashcard_pets/screens/friends_subscreen.dart';
import 'package:flashcard_pets/screens/leaderboard_subscreen.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';

class SocialScreen extends StatelessWidget {
  //Mocked data
  final bool isUserLoggedIn = true;
  final bool isUserSyncronized = true;
  const SocialScreen({super.key});

  Widget needLoginSubscreen(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Você precisa estar autenticado para acessar os recursos sociais.",
            style: body,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          ThemedFilledButton(
            label: "Entrar",
            onPressed: () {},
            width: 150,
          ),
          const SizedBox(
            height: 8,
          ),
          ThemedFilledButton(
            label: "Cadastrar",
            onPressed: () {},
            width: 150,
          ),
        ],
      ),
    );
  }

  Widget needSyncSubscreen(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Você precisa sincronizar seus dados para acessar recursos sociais.",
            style: body,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          ThemedFilledButton(
            label: "Sincronizar",
            onPressed: () {},
            width: 150,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;

    return ScreenLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const UserStatsHeader(),
          if (!isUserLoggedIn) needLoginSubscreen(context),
          if (isUserLoggedIn && !isUserSyncronized) needSyncSubscreen(context),
          if (isUserLoggedIn && isUserSyncronized)
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
                        Tab(text: "Amigos"),
                        Tab(
                          text: "Placar",
                        )
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          FriendsSubscreen(),
                          LeaderboardSubscreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
