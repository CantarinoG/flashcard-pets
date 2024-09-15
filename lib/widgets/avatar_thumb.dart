import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';

class AvatarThumb extends StatelessWidget {
  //Mocked data
  final bool _isSelected = false;
  final String _imgPath = "assets/images/baby_pets/beagle.png";
  final bool _isLocked = false;
  final int _unlockLevel = 30;
  const AvatarThumb({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color bright = Theme.of(context).colorScheme.bright;

    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: (_isSelected && !_isLocked)
            ? Border.all(
                color: secondary,
                width: 4.0,
              )
            : null,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {},
        child: _isLocked
            ? ClipOval(
                child: Container(
                  decoration: BoxDecoration(color: bright),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock,
                        color: secondary,
                      ),
                      Text(
                        "Lvl $_unlockLevel",
                        style: h3?.copyWith(
                          color: secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : ClipOval(
                child: Image.asset(
                  _imgPath,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
