import 'package:flashcard_pets/screens/awards_screen.dart';
import 'package:flashcard_pets/screens/change_avatar_screen.dart';
import 'package:flashcard_pets/screens/statistics_screen.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/widgets/award_card_basic.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/statistics_display.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';

class SelfProfileScreen extends StatelessWidget {
  //Mocked data
  final String _imgPath = "assets/images/baby_pets/beagle.png";
  final String _name = "Guilherme Cantarino";
  final String _nick = "CantarinoG";
  final int _currentXp = 450;
  final int _nextLevelXp = 520;
  final int _reviewedCardsNum = 23;
  final int _accuracy = 84;
  final int _streak = 4;
  const SelfProfileScreen({super.key});

  void _changeAvatar(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChangeAvatarScreen(),
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
        builder: (context) => AwardsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color disabled = Theme.of(context).disabledColor;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;

    return ScreenLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  child: ClipOval(
                    child: Image.asset(
                      _imgPath,
                      fit: BoxFit
                          .cover, // Ensures the image fits nicely within the circular shape
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
                    text: " $_currentXp/$_nextLevelXp",
                    style: body?.copyWith(
                      color: secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
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
          const SizedBox(
            height: 4,
          ),
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
          const Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: AwardCardBasic()),
                Expanded(child: AwardCardBasic()),
                Expanded(child: AwardCardBasic()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
