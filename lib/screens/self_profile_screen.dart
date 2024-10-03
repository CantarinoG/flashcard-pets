import 'package:flashcard_pets/dialogs/single_input_dialog.dart';
import 'package:flashcard_pets/dialogs/sync_dialog.dart';
import 'package:flashcard_pets/main.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/constants/avatar_data_provider.dart';
import 'package:flashcard_pets/providers/services/firebase_auth_provider.dart';
import 'package:flashcard_pets/providers/services/user_json_data_provider.dart';
import 'package:flashcard_pets/screens/awards_screen.dart';
import 'package:flashcard_pets/screens/change_avatar_screen.dart';
import 'package:flashcard_pets/screens/configurations_screen.dart';
import 'package:flashcard_pets/screens/statistics_screen.dart';
import 'package:flashcard_pets/snackbars/success_snackbar.dart';
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
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SelfProfileScreen extends StatelessWidget {
  const SelfProfileScreen({super.key});

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

  void _copyId(BuildContext context, String id) {
    Clipboard.setData(ClipboardData(text: id));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const SuccessSnackbar("Id copiado."),
        backgroundColor: Theme.of(context).colorScheme.bright,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _logout(BuildContext context) async {
    await Provider.of<FirebaseAuthProvider>(context, listen: false).signOut();
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
    final Color primary = Theme.of(context).colorScheme.primary;

    final UserJsonDataProvider userProvider = Provider.of<UserJsonDataProvider>(
      context,
    );

    FirebaseAuthProvider authProvider =
        Provider.of<FirebaseAuthProvider>(context);
    final _isUserLoggedIn = authProvider.user != null;

    return FutureBuilder<User?>(
      future: userProvider.readData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else if (snapshot.hasError) {
          return NoItemsPlaceholder('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const NoItemsPlaceholder('No user data available');
        }

        final user = snapshot.data!;

        final String avatarPath = Provider.of<AvatarDataProvider>(context)
            .retrieveFromKey(user.avatarCode);

        final List<int> last3Awards = user.awards.length > 3
            ? user.awards.sublist(user.awards.length - 3)
            : user.awards;

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
                        user.name,
                        style: h2?.copyWith(color: secondary),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      if (_isUserLoggedIn) ...[
                        const SizedBox(
                          height: 4,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            children: [
                              ThemedFilledButton(
                                  label: "Sair da Conta",
                                  onPressed: () {
                                    _logout(context);
                                  }),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "id ",
                                    style: h3?.copyWith(color: secondary),
                                  ),
                                  Text(
                                    "${authProvider.uid}",
                                    style: h3?.copyWith(color: disabled),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _copyId(context, authProvider.uid ?? "");
                                    },
                                    icon: Icon(
                                      Icons.copy,
                                      color: primary,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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
                            "${user.totalReviewedCards}",
                            Icons.dashboard,
                          ),
                          StatisticsDisplay(
                            "Taxa de Acerto",
                            "${((user.totalRightCardsReviewed / user.totalReviewedCards) * 100).toStringAsFixed(1)}%",
                            Icons.track_changes_outlined,
                          ),
                          StatisticsDisplay(
                            "Sequência de Dias",
                            "${user.streak}",
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: last3Awards.isEmpty
                              ? [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 60.0),
                                    child: Text(
                                      "Não conquistou nenhuma conquista ainda.",
                                      style: body,
                                    ),
                                  )
                                ]
                              : last3Awards.map((awardCode) {
                                  return AwardCardBasic(awardCode);
                                }).toList(),
                        ),
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
        builder: (context) => ConfigurationsScreen(),
      ),
    );
  }

  void _changeName(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SingleInputDialog<String>(
          title: "Mudar o Nome de Usuário",
          description: "Insira o novo nome.",
          label: "Nome",
        );
      },
    ).then((value) async {
      if (value != null && value.isNotEmpty) {
        UserJsonDataProvider provider = Provider.of<UserJsonDataProvider>(
          context,
          listen: false,
        );
        User? user = await provider.readData();
        if (user == null) return;
        user.name = value;
        provider.writeData(user);
      }
    });
  }

  void _changeTheme(BuildContext context) async {
    final UserJsonDataProvider provider =
        Provider.of<UserJsonDataProvider>(context, listen: false);
    final User? user = await provider.readData();
    if (user != null) {
      user.darkMode = !user.darkMode;
      await provider.writeData(user);
      MyApp.of(context)
          .changeTheme(user.darkMode ? ThemeMode.dark : ThemeMode.light);
    }
  }

  void _sync(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SyncDialog();
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final Color brightColor = Theme.of(context).colorScheme.bright;
    final Color primary = Theme.of(context).colorScheme.primary;

    final TextStyle? body = Theme.of(context).textTheme.bodySmall;

    FirebaseAuthProvider authProvider =
        Provider.of<FirebaseAuthProvider>(context);
    final _isUserLoggedIn = authProvider.user != null;

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
                _sync(context);
                break;
              case SelfProfileAction.toggleTheme:
                _changeTheme(context);
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
            if (_isUserLoggedIn)
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
