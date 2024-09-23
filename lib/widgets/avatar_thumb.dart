// ignore_for_file: unused_local_variable

import 'package:flashcard_pets/data_providers/i_data_provider.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarThumb extends StatelessWidget {
  //Mocked data
  final int userAvatarId = 0;
  final int avatarId;
  const AvatarThumb(this.avatarId, {super.key});

  void _onTap() {
    //...
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color bright = Theme.of(context).colorScheme.bright;

    final String avatarImgPath =
        Provider.of<IDataProvider<String>>(context).retrieveData()[avatarId]!;

    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: (userAvatarId == avatarId)
            ? Border.all(
                color: secondary,
                width: 4.0,
              )
            : null,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(60),
        onTap: _onTap,
        child: ClipOval(
          child: Image.asset(
            avatarImgPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
