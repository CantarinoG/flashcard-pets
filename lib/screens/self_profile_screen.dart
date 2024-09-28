import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/constants/i_data_provider.dart';
import 'package:flashcard_pets/providers/services/i_json_data_provider.dart';
import 'package:flashcard_pets/screens/awards_screen.dart';
import 'package:flashcard_pets/screens/change_avatar_screen.dart';
import 'package:flashcard_pets/screens/configurations_screen.dart';
import 'package:flashcard_pets/screens/statistics_screen.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/award_card_basic.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/statistics_display.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelfProfileScreen extends StatelessWidget {
  //Mocked data
  final String _name = "Guilherme Cantarino";
  final String _nick = "CantarinoG";
  final int _currentXp = 450;
  final int _nextLevelXp = 520;
  final int _reviewedCardsNum = 23;
  final int _accuracy = 84;
  final int _streak = 4;
  final List<int> _last3Awards = [
    4,
    6,
    13,
  ];
  SelfProfileScreen({super.key});

  void _changeAvatar(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeAvatarScreen(),
      ),
    );
  }

  void _seeStatistic(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StatisticsScreen(),
      ),
    );
  }

  void _seeAwards(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AwardsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final Color disabled = Theme.of(context).disabledColor;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    final IJsonDataProvider<User> userProvider =
        Provider.of<IJsonDataProvider<User>>(
      context,
    );

    return FutureBuilder<User?>(
      future: userProvider.readData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.hasError) {
          return NoItemsPlaceholder('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const NoItemsPlaceholder('No user data available');
        }

        final user = snapshot.data!;

        final String avatarPath = Provider.of<IDataProvider<String>>(context)
            .retrieveFromKey(user.avatarCode);

        return ScreenLayout(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 133,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 200,
                              width: 200,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(user.bgColorCode),
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    avatarPath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton.filled(
                                  onPressed: () {
                                    _changeAvatar(context);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        _name,
                        style: h2?.copyWith(color: secondary),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "@$_nick",
                        style: h3?.copyWith(color: disabled),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const UserStatsHeader(),
                      SizedBox(
                        width: double.infinity,
                        child: RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "XP",
                                style: h4.copyWith(
                                  color: secondary,
                                ),
                              ),
                              TextSpan(
                                text:
                                    " ${user.currentLevelXp}/${user.nextLevelXp}",
                                style: body?.copyWith(
                                  color: secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          StatisticsDisplay(
                            "Cartões Revisados",
                            "$_reviewedCardsNum",
                            Icons.dashboard,
                          ),
                          StatisticsDisplay(
                            "Taxa de Acerto",
                            "$_accuracy%",
                            Icons.track_changes_outlined,
                          ),
                          StatisticsDisplay(
                            "Sequência de Dias",
                            "$_streak",
                            Icons.local_fire_department,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      ThemedFilledButton(
                        label: "Ver Estatísticas",
                        onPressed: () {
                          _seeStatistic(context);
                        },
                        width: double.infinity,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Conquistas",
                            style: h3?.copyWith(color: secondary),
                          ),
                          TextButton(
                            onPressed: () {
                              _seeAwards(context);
                            },
                            child: Text(
                              "Ver todas",
                              style: bodyEm,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: AwardCardBasic(_last3Awards[0])),
                          Expanded(child: AwardCardBasic(_last3Awards[1])),
                          Expanded(child: AwardCardBasic(_last3Awards[2])),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

enum SelfProfileAction {
  synchronize,
  toggleTheme,
  configurations,
  changeName,
}

class SelfProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SelfProfileAppBar({super.key});

  void _changeSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ConfigurationsScreen(),
      ),
    );
  }

  void _changeName(BuildContext context) {
    /*showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ChangeNameDialog();
      },
    );*/
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final Color brightColor = Theme.of(context).colorScheme.bright;
    final Color primary = Theme.of(context).colorScheme.primary;

    final TextStyle? body = Theme.of(context).textTheme.bodySmall;

    return ThemedAppBar(
      "Perfil",
      actions: [
        PopupMenuButton<SelfProfileAction>(
          tooltip: "Ver opções",
          iconColor: primary,
          color: brightColor,
          onSelected: (SelfProfileAction result) {
            switch (result) {
              case SelfProfileAction.synchronize:
                break;
              case SelfProfileAction.toggleTheme:
                break;
              case SelfProfileAction.configurations:
                _changeSettings(context);
                break;
              case SelfProfileAction.changeName:
                _changeName(context);
                break;
            }
          },
          itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<SelfProfileAction>>[
            PopupMenuItem<SelfProfileAction>(
              value: SelfProfileAction.synchronize,
              child: Text(
                'Sincronizar',
                style: body,
              ),
            ),
            PopupMenuItem<SelfProfileAction>(
              value: SelfProfileAction.toggleTheme,
              child: Text(
                'Mudar Tema (Claro/Escuro)',
                style: body,
              ),
            ),
            PopupMenuItem<SelfProfileAction>(
              value: SelfProfileAction.configurations,
              child: Text(
                'Configurações',
                style: body,
              ),
            ),
            PopupMenuItem<SelfProfileAction>(
              value: SelfProfileAction.changeName,
              child: Text(
                'Alterar Nome',
                style: body,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
