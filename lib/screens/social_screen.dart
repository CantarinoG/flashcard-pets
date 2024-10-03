import 'package:flashcard_pets/dialogs/notifications_dialog.dart';
import 'package:flashcard_pets/providers/services/firebase_auth_provider.dart';
import 'package:flashcard_pets/screens/auth_screen.dart';
import 'package:flashcard_pets/screens/friends_subscreen.dart';
import 'package:flashcard_pets/screens/leaderboard_subscreen.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_fab.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocialScreen extends StatelessWidget {
  final bool _isUserSyncronized = false;
  const SocialScreen({super.key});

  void _logIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthScreen(
          isLogIn: true,
        ),
      ),
    );
  }

  void _signUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthScreen(
          isLogIn: false,
        ),
      ),
    );
  }

  void _sync() {
    //...
  }

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
            onPressed: () {
              _logIn(context);
            },
            width: 150,
          ),
          const SizedBox(
            height: 8,
          ),
          ThemedFilledButton(
            label: "Cadastrar",
            onPressed: () {
              _signUp(context);
            },
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
            onPressed: _sync,
            width: 150,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    FirebaseAuthProvider authProvider =
        Provider.of<FirebaseAuthProvider>(context);
    final _isUserLoggedIn = authProvider.user != null;

    return ScreenLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const UserStatsHeader(),
          if (!_isUserLoggedIn) needLoginSubscreen(context),
          if (_isUserLoggedIn && !_isUserSyncronized)
            needSyncSubscreen(context),
          if (_isUserLoggedIn && _isUserSyncronized)
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

class SocialAppBar extends StatelessWidget implements PreferredSizeWidget {
  //Mocked data
  final bool _userIsSynced = false;
  final bool _anySocialNotifications = true;
  const SocialAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _showNotification(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NotificationsDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuthProvider authProvider =
        Provider.of<FirebaseAuthProvider>(context);
    final _isUserLoggedIn = authProvider.user != null;

    return ThemedAppBar(
      "Social",
      actions: (_isUserLoggedIn && _userIsSynced)
          ? [
              IconButton(
                onPressed: () {
                  _showNotification(context);
                },
                icon: Badge(
                  backgroundColor:
                      _anySocialNotifications ? Colors.red : Colors.transparent,
                  child: const Icon(
                    Icons.notifications,
                  ),
                ),
              ),
            ]
          : null,
    );
  }
}

class SocialFab extends StatelessWidget {
  //Mocked data
  final bool _userIsSynced = false;

  const SocialFab({super.key});

  void _onTap(BuildContext context) {
    /*showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddFriendDialog();
      },
    );*/
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuthProvider authProvider =
        Provider.of<FirebaseAuthProvider>(context);
    final _isUserLoggedIn = authProvider.user != null;

    return (_userIsSynced && _isUserLoggedIn)
        ? ThemedFab(
            () {
              _onTap(context);
            },
            const Icon(Icons.add),
          )
        : const SizedBox.shrink();
  }
}
