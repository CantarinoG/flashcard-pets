// ignore_for_file: use_build_context_synchronously

import 'package:flashcard_pets/providers/constants/avatar_data_provider.dart';
import 'package:flashcard_pets/providers/services/firebase_auth_provider.dart';
import 'package:flashcard_pets/providers/services/firebase_social_provider.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/widgets/award_card_basic.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/statistics_display.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  final String userId;
  const UserProfileScreen(this.userId, {super.key});

  void _addFriend(BuildContext context) async {
    final String ownUserId =
        Provider.of<FirebaseAuthProvider>(context, listen: false).uid!;
    final result =
        await Provider.of<FirebaseSocialProvider>(context, listen: false)
            .addFriend(ownUserId, userId);
    if (result != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Amigo adicionado com sucesso!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final Color disabled = Theme.of(context).disabledColor;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    final String ownUserId = Provider.of<FirebaseAuthProvider>(context).uid!;

    return FutureBuilder<Map<String, dynamic>?>(
      future: Future.wait([
        Provider.of<FirebaseSocialProvider>(context, listen: false)
            .getUserInfo(userId),
        Provider.of<FirebaseSocialProvider>(context, listen: false)
            .getFriendsIdList(ownUserId),
      ]).then((List<dynamic> results) {
        final Map<String, dynamic>? userInfo = results[0];
        final List<String> friendsList = results[1];
        if (userInfo != null) {
          userInfo['isFriend'] = friendsList.contains(userId);
        }
        return userInfo;
      }),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final userInfo = snapshot.data;
        if (userInfo == null) {
          return const Scaffold(
            body: Center(child: Text('User not found')),
          );
        }

        final String avatarPath = Provider.of<AvatarDataProvider>(context)
            .retrieveFromKey(userInfo['avatarCode'] ?? 0);

        final List<int> awards =
            (userInfo["awards"] as List<dynamic>).cast<int>();

        return Scaffold(
          appBar: const ThemedAppBar(""),
          body: ScreenLayout(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 72,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  Color(userInfo['bgColorCode'] ?? 0xFFFFFFFF),
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
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          userInfo['name'] ?? 'Usuário',
                          style: h2?.copyWith(color: secondary),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "id $userId",
                          style: h3?.copyWith(color: disabled),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Lvl ',
                                  style: h4.copyWith(
                                    color: secondary,
                                  ),
                                ),
                                TextSpan(
                                  text: '${userInfo['level'] ?? 0}',
                                  style: h3,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (!userInfo['isFriend'] && userId != ownUserId)
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ThemedFilledButton(
                              label: "Adicionar Amigo",
                              onPressed: () => _addFriend(context),
                            ),
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StatisticsDisplay(
                          "Cartões Revisados",
                          "${userInfo['totalReviewedCards'] ?? 0}",
                          Icons.dashboard,
                        ),
                        StatisticsDisplay(
                          "Taxa de Acerto",
                          "${((userInfo["totalRightCardsReviewed"] / userInfo["totalReviewedCards"]) * 100).toStringAsFixed(1)}%",
                          Icons.track_changes_outlined,
                        ),
                        StatisticsDisplay(
                          "Sequência de Dias",
                          "${userInfo['streak'] ?? 0}",
                          Icons.local_fire_department,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Conquistas",
                          style: h3?.copyWith(
                            color: secondary,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: awards.isEmpty
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
                                : awards.map((awardCode) {
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
          ),
        );
      },
    );
  }
}
