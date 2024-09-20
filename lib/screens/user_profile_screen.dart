// ignore_for_file: unused_local_variable

import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/widgets/award_card_basic.dart';
import 'package:flashcard_pets/widgets/pet_card_basic.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/statistics_display.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  //Mocked data
  final String _imgPath = "assets/images/baby_pets/beagle.png";
  final String _name = "Guilherme Cantarino";
  final String _nick = "CantarinoG";
  final int _level = 5;
  final int _currentXp = 450;
  final int _nextLevelXp = 520;
  late final double _progress = _currentXp / _nextLevelXp;
  final bool _isFriend = false;
  final int _reviewedCardsNum = 23;
  final int _accuracy = 84;
  final int _streak = 4;
  final List<int> _awards = [1, 1, 1, 1, 1, 1];
  final List<int> _pets = [1, 1, 1, 1, 1, 1];
  UserProfileScreen({super.key});

  void _addFriend() {
    //...
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final Color disabled = Theme.of(context).disabledColor;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;

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
                      child: ClipOval(
                        child: Image.asset(
                          _imgPath,
                          fit: BoxFit.cover,
                        ),
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
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Lvl $_level",
                        style: h3,
                      ),
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
                            _progress / 2,
                            _progress,
                            _progress,
                          ])),
                      child: const SizedBox(height: 8),
                    ),
                    if (!_isFriend)
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ThemedFilledButton(
                          label: "Adicionar Amigo",
                          onPressed: _addFriend,
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
                        children: _awards.map((award) {
                          return const AwardCardBasic();
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Pets",
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
                        children: _pets.map((award) {
                          return const PetCardBasic();
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
  }
}
