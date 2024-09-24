import 'package:flashcard_pets/providers/constants/i_data_provider.dart';
import 'package:flashcard_pets/screens/user_profile_screen.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaderboardUserCard extends StatelessWidget {
  //Mocked data
  final int _colorCode = 0xFF5C9EAD;
  final int _position = 1;
  final int _avatarId = 10;
  final String _name = "Guilherme Cantarino";
  final String _nick = "CantarinoG";
  final int _pontos = 1456;

  const LeaderboardUserCard({super.key});

  void _visitUserProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h1 = Theme.of(context).textTheme.headlineLarge;
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final Color brightColor = Theme.of(context).colorScheme.bright;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    final String avatarPath =
        Provider.of<IDataProvider<String>>(context).retrieveFromKey(_avatarId);

    Color positionColor = secondary;
    if (_position == 1) {
      positionColor = const Color(0xFFDAC387);
    } else if (_position == 2) {
      positionColor = const Color(0xFF9BABB1);
    } else if (_position == 3) {
      positionColor = const Color(0xFFBDA655);
    }

    return Card(
      elevation: 4,
      color: brightColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _visitUserProfile(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$_position°",
                style: h1?.copyWith(color: positionColor),
              ),
              const SizedBox(
                width: 16,
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(_colorCode),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      avatarPath,
                      fit: BoxFit
                          .cover, // Ensures the image fits nicely within the circular shape
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _name,
                        style: h3?.copyWith(
                          color: secondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        "@$_nick",
                        style: body,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    "$_pontos",
                    style: h4.copyWith(color: secondary),
                  ),
                  Text(
                    "pontos",
                    style: bodyEm.copyWith(color: secondary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
