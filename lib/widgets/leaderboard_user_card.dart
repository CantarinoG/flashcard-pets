import 'package:flashcard_pets/providers/constants/avatar_data_provider.dart';
import 'package:flashcard_pets/screens/user_profile_screen.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaderboardUserCard extends StatelessWidget {
  final int ranking;
  final int avatarCode;
  final int bgColorCode;
  final String name;
  final String id;
  final int totalXp;

  const LeaderboardUserCard({
    super.key,
    required this.ranking,
    required this.avatarCode,
    required this.bgColorCode,
    required this.name,
    required this.id,
    required this.totalXp,
  });

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
    final Color disabled = Theme.of(context).disabledColor;

    final String avatarPath =
        Provider.of<AvatarDataProvider>(context).retrieveFromKey(avatarCode);

    Color positionColor = secondary;
    if (ranking == 1) {
      positionColor = const Color(0xFFDAC387);
    } else if (ranking == 2) {
      positionColor = const Color(0xFF9BABB1);
    } else if (ranking == 3) {
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
                "$ranking°",
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
                    color: Color(bgColorCode),
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
                        name,
                        style: h3?.copyWith(
                          color: secondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        "id $id",
                        style: body?.copyWith(color: disabled),
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
                    "$totalXp",
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
