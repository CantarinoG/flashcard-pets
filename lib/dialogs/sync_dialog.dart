// ignore_for_file: use_build_context_synchronously

import 'package:flashcard_pets/models/user.dart' as model;
import 'package:flashcard_pets/providers/services/firebase_auth_provider.dart';
import 'package:flashcard_pets/providers/services/sync_provider.dart';
import 'package:flashcard_pets/providers/services/user_json_data_provider.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SyncDialog extends StatefulWidget {
  const SyncDialog({super.key});

  @override
  State<SyncDialog> createState() => _SyncDialogState();
}

class _SyncDialogState extends State<SyncDialog> {
  bool _isLoading = false;
  String? errorMsg;

  void _cancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  void _chooseLocal(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final model.User? user =
        await Provider.of<UserJsonDataProvider>(context, listen: false)
            .readData();
    final String? userFirebaseId =
        Provider.of<FirebaseAuthProvider>(context, listen: false).uid;
    if (user == null || userFirebaseId == null) return;
    final String? anyError =
        await Provider.of<SyncProvider>(context, listen: false)
            .upload(user, userFirebaseId);
    setState(() {
      _isLoading = false;
    });

    if (anyError != null) {
      setState(() {
        errorMsg = anyError;
      });
      return;
    }
    Navigator.of(context).pop();
  }

  void _chooseRemote(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final model.User? user =
        await Provider.of<UserJsonDataProvider>(context, listen: false)
            .readData();
    final String? userFirebaseId =
        Provider.of<FirebaseAuthProvider>(context, listen: false).uid;
    if (user == null || userFirebaseId == null) return;
    final String? anyError =
        await Provider.of<SyncProvider>(context, listen: false)
            .download(user, userFirebaseId);
    setState(() {
      _isLoading = false;
    });

    if (anyError != null) {
      setState(() {
        errorMsg = anyError;
      });
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color error = Theme.of(context).colorScheme.error;

    return AlertDialog(
      title: Text(
        "Quais Dados Deseja Manter?",
        style: h2?.copyWith(
          color: secondary,
        ),
      ),
      content: FutureBuilder<Map<String, dynamic>>(
        future: Future.wait([
          Provider.of<UserJsonDataProvider>(context, listen: false).readData(),
          Provider.of<SyncProvider>(context, listen: false).getUserData(
            Provider.of<FirebaseAuthProvider>(context, listen: false).uid ?? '',
          ),
        ]).then((results) {
          final localUser = results[0] as model.User?;
          final remoteData = results[1] as Map<String, dynamic>?;
          return {
            'localUser': localUser,
            'remoteData': remoteData,
          };
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Loading(),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(
              "Erro: ${snapshot.error}",
              style: body?.copyWith(color: error),
            );
          } else if (!snapshot.hasData) {
            return Text(
              "Sem dados disponíveis",
              style: body,
            );
          }

          final localUser = snapshot.data!['localUser'] as model.User?;
          final remoteData =
              snapshot.data!['remoteData'] as Map<String, dynamic>?;

          final localLevel = localUser?.level ?? 0;
          final localGold = localUser?.gold ?? 0;
          final localReviews = localUser?.totalReviewedCards ?? 0;
          final localLastTimeUsedApp = localUser?.lastTimeUsedApp;

          final remoteLevel = remoteData?['level'] as int?;
          final remoteGold = remoteData?['gold'] as int?;
          final remoteReviews = remoteData?['totalReviewedCards'] as int?;
          final remoteLastTimeUsedApp = remoteData?["lastSync"] as DateTime?;

          return _isLoading
              ? const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Loading(),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: secondary,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Dados Locais",
                                  style: h3?.copyWith(
                                    color: secondary,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "LVL",
                                      style: h4.copyWith(
                                        color: secondary,
                                      ),
                                    ),
                                    Text(
                                      " $localLevel",
                                      style: body,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/custom_icons/coin.svg",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(
                                      " $localGold",
                                      style: body,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Revisões",
                                      style: body?.copyWith(
                                        color: secondary,
                                      ),
                                    ),
                                    Text(
                                      " $localReviews",
                                      style: body,
                                    ),
                                  ],
                                ),
                                Text(
                                  "Atualizado em",
                                  style: body?.copyWith(
                                    color: secondary,
                                  ),
                                ),
                                Text(
                                  " ${_formatDate(localLastTimeUsedApp!)}",
                                  style: body,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          if (remoteGold != null &&
                              remoteLevel != null &&
                              remoteLastTimeUsedApp != null &&
                              remoteReviews != null)
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: secondary,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Dados na Nuvem",
                                    style: h3?.copyWith(
                                      color: secondary,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "LVL",
                                        style: h4.copyWith(
                                          color: secondary,
                                        ),
                                      ),
                                      Text(
                                        " $remoteLevel",
                                        style: body,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/custom_icons/coin.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(
                                        " $remoteGold",
                                        style: body,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Revisões",
                                        style: body?.copyWith(
                                          color: secondary,
                                        ),
                                      ),
                                      Text(
                                        " $remoteReviews",
                                        style: body,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Atualizado em",
                                    style: body?.copyWith(
                                      color: secondary,
                                    ),
                                  ),
                                  Text(
                                    " ${_formatDate(remoteLastTimeUsedApp)}",
                                    style: body,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ThemedFilledButton(
                            label: "Local",
                            onPressed: () {
                              _chooseLocal(context);
                            }),
                        const SizedBox(
                          width: 16,
                        ),
                        if (remoteGold != null &&
                            remoteLevel != null &&
                            remoteLastTimeUsedApp != null &&
                            remoteReviews != null)
                          ThemedFilledButton(
                              label: "Nuvem",
                              onPressed: () {
                                _chooseRemote(context);
                              })
                      ],
                    ),
                    if (errorMsg != null)
                      Text(
                        errorMsg!,
                        style: body?.copyWith(
                          color: error,
                        ),
                      ),
                  ],
                );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            _cancel(context);
          },
          child: Text(
            "Cancelar",
            style: bodyEm.copyWith(
              color: primary,
            ),
          ),
        ),
      ],
    );
  }
}
