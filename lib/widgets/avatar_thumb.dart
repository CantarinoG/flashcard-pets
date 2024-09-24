import 'package:flashcard_pets/providers/constants/i_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarThumb extends StatelessWidget {
  //Mocked data
  final int userAvatarId = 0;
  final int _colorCode = 0xFF5C9EAD;
  final int avatarId;
  const AvatarThumb(this.avatarId, {super.key});

  void _onTap() {
    //...
  }

  @override
  Widget build(BuildContext context) {
    final Color secondary = Theme.of(context).colorScheme.secondary;

    final String avatarImgPath =
        Provider.of<IDataProvider<String>>(context).retrieveFromKey(avatarId);

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
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(_colorCode),
          ),
          child: ClipOval(
            child: Image.asset(
              avatarImgPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
