import 'package:flashcard_pets/models/award.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/constants/award_data_provider.dart';
import 'package:flashcard_pets/providers/services/standard_game_elements_calculations.dart';
import 'package:flashcard_pets/providers/services/user_json_data_provider.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AwardCard extends StatelessWidget {
  final int awardId;
  final int userProgress;

  const AwardCard(this.awardId, this.userProgress, {super.key});

  void _claimAward(Award award, User user, BuildContext context) async {
    user.awards.add(awardId);
    User updatedUser =
        Provider.of<StandardGameElementsCalculations>(context, listen: false)
            .addGoldAndXp(user, award.rewardValue, award.rewardValue, context);
    updatedUser.totalGoldEarned += award.rewardValue;
    await Provider.of<UserJsonDataProvider>(context, listen: false)
        .writeData(updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    Color brightColor = Theme.of(context).colorScheme.bright;
    Color primary = Theme.of(context).colorScheme.primary;
    Color secondary = Theme.of(context).colorScheme.secondary;
    Color text = Theme.of(context).colorScheme.text;

    TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    TextStyle? h3em = Theme.of(context).textTheme.headlineSmallEm;
    TextStyle? body = Theme.of(context).textTheme.bodySmall;
    TextStyle? bodyEm = Theme.of(context).textTheme.bodySmallEm;

    final UserJsonDataProvider userProvider =
        Provider.of<UserJsonDataProvider>(context);

    final Award award =
        Provider.of<AwardDataProvider>(context).retrieveFromKey(awardId);

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

        final User user = snapshot.data!;
        final double progress = ((userProgress / award.target) > 1)
            ? 1
            : (userProgress / award.target);
        final bool alreadyUnlocked = user.awards.contains(awardId);

        return Card(
          elevation: 4,
          color: brightColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: ClipOval(
                        child: Image.asset(
                          award.iconPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            award.title,
                            style: h3?.copyWith(
                              color: secondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            award.description,
                            style: body,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(colors: [
                        primary,
                        secondary,
                        const Color.fromARGB(255, 201, 201, 201),
                      ], stops: [
                        progress / 2,
                        progress,
                        progress,
                      ])),
                  child: const SizedBox(height: 8),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "$userProgress/${award.target}",
                    style: body?.copyWith(
                      color: secondary,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Recompensa:",
                      style: bodyEm.copyWith(
                        color: text,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    SvgPicture.asset(
                      "assets/images/custom_icons/coin.svg",
                      width: 30,
                      height: 30,
                    ),
                    Text(
                      "${award.rewardValue}",
                      style: body?.copyWith(
                        color: text,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      "XP ",
                      style: h3em.copyWith(color: secondary),
                    ),
                    Text(
                      "${award.rewardValue}",
                      style: body?.copyWith(
                        color: text,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                if (!alreadyUnlocked)
                  ThemedFilledButton(
                    label: "Resgatar Recompensa",
                    onPressed: (userProgress < award.target)
                        ? null
                        : () {
                            _claimAward(award, user, context);
                          },
                  ),
                if (alreadyUnlocked)
                  Text(
                    "Concluído!",
                    style: h3?.copyWith(
                      color: secondary,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
