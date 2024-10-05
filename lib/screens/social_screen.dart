// ignore_for_file: use_build_context_synchronously

import 'package:flashcard_pets/dialogs/add_friend_dialog.dart';
import 'package:flashcard_pets/dialogs/notifications_dialog.dart';
import 'package:flashcard_pets/dialogs/sync_dialog.dart';
import 'package:flashcard_pets/providers/services/firebase_auth_provider.dart';
import 'package:flashcard_pets/providers/services/firebase_social_provider.dart';
import 'package:flashcard_pets/providers/services/sync_provider.dart';
import 'package:flashcard_pets/screens/auth_screen.dart';
import 'package:flashcard_pets/screens/friends_subscreen.dart';
import 'package:flashcard_pets/screens/leaderboard_subscreen.dart';
import 'package:flashcard_pets/snackbars/error_snackbar.dart';
import 'package:flashcard_pets/snackbars/success_snackbar.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_fab.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
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

  void _sync(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SyncDialog();
      },
    );
    setState(() {});
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
            onPressed: () {
              _sync(context);
            },
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
    final isUserLoggedIn = authProvider.user != null;

    SyncProvider syncProvider = Provider.of<SyncProvider>(context);

    return FutureBuilder<Map<String, dynamic>?>(
      future: syncProvider.getUserData(authProvider.user?.uid ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        bool isUserSyncronized = false;
        final userData = snapshot.data;
        if (userData != null) {
          final time = userData["lastSync"];
          final currentTime = DateTime.now();
          final difference = currentTime.difference(time);
          isUserSyncronized = difference.inMinutes <= 30;
        }

        return ScreenLayout(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const UserStatsHeader(),
              if (!isUserLoggedIn) needLoginSubscreen(context),
              if (isUserLoggedIn && !isUserSyncronized)
                needSyncSubscreen(context),
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
                        const Expanded(
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
      },
    );
  }
}

class SocialAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SocialAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _showNotification(BuildContext context) async {
    final String? userId =
        Provider.of<FirebaseAuthProvider>(context, listen: false).uid;
    if (userId == null) return;
    final Map<String, dynamic>? userData =
        await Provider.of<SyncProvider>(context, listen: false)
            .getUserData(userId);
    if (userData == null) return;
    final time = userData["lastSync"];
    final currentTime = DateTime.now();
    final difference = currentTime.difference(time);
    final bool isUserSyncronized = difference.inMinutes <= 30;
    if (!isUserSyncronized) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NotificationsDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuthProvider authProvider =
        Provider.of<FirebaseAuthProvider>(context);
    final isUserLoggedIn = authProvider.user != null;

    return ThemedAppBar(
      "Social",
      actions: (isUserLoggedIn)
          ? [
              IconButton(
                onPressed: () {
                  _showNotification(context);
                },
                icon: const Icon(
                  Icons.notifications,
                ),
              ),
            ]
          : null,
    );
  }
}

class SocialFab extends StatelessWidget {
  const SocialFab({super.key});

  void _onTap(BuildContext context) async {
    final String? userId =
        Provider.of<FirebaseAuthProvider>(context, listen: false).uid;
    if (userId == null) return;
    final Map<String, dynamic>? userData =
        await Provider.of<SyncProvider>(context, listen: false)
            .getUserData(userId);
    if (userData == null) return;
    final time = userData["lastSync"];
    final currentTime = DateTime.now();
    final difference = currentTime.difference(time);
    final bool isUserSyncronized = difference.inMinutes <= 30;
    if (!isUserSyncronized) return;

    final String? friendId = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddFriendDialog();
      },
    );
    if (friendId == null) return;

    final result =
        await Provider.of<FirebaseSocialProvider>(context, listen: false)
            .addFriend(userId, friendId);
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: ErrorSnackbar(result),
          backgroundColor: Theme.of(context).colorScheme.bright,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const SuccessSnackbar("Adicionado com sucesso!"),
          backgroundColor: Theme.of(context).colorScheme.bright,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuthProvider authProvider =
        Provider.of<FirebaseAuthProvider>(context);
    final isUserLoggedIn = authProvider.user != null;

    return (isUserLoggedIn)
        ? ThemedFab(
            () {
              _onTap(context);
            },
            const Icon(Icons.add),
          )
        : const SizedBox.shrink();
  }
}
