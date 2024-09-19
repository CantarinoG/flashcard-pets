import 'package:flashcard_pets/screens/user_profile_screen.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FriendCard extends StatelessWidget {
  //Mocked data
  final String _imgPath = "assets/images/baby_pets/beagle.png";
  final String _name = "Guilherme Cantarino";
  final String _nick = "CantarinoG";
  final bool _canSendGift = true;
  const FriendCard({super.key});

  void _visitFriendProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileScreen(),
      ),
    );
  }

  void _sendGift() {
    //...
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color brightColor = Theme.of(context).colorScheme.bright;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return Card(
      elevation: 4,
      color: brightColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _visitFriendProfile(context);
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
              SizedBox(
                height: 50,
                width: 50,
                child: ClipOval(
                  child: Image.asset(
                    _imgPath,
                    fit: BoxFit
                        .cover, // Ensures the image fits nicely within the circular shape
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
              IconButton.filled(
                onPressed: _canSendGift ? _sendGift : null,
                icon: SvgPicture.asset(
                  "assets/images/custom_icons/gift_icon.svg",
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
