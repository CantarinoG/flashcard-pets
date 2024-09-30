import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/constants/avatar_data_provider.dart';
import 'package:flashcard_pets/providers/services/user_json_data_provider.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarThumb extends StatelessWidget {
  final int avatarId;
  const AvatarThumb(this.avatarId, {super.key});

  void _onTap(BuildContext context, User user, int avatarCode) async {
    user.avatarCode = avatarCode;
    await Provider.of<UserJsonDataProvider>(context, listen: false)
        .writeData(user);
  }

  @override
  Widget build(BuildContext context) {
    final Color secondary = Theme.of(context).colorScheme.secondary;

    final String avatarImgPath =
        Provider.of<AvatarDataProvider>(context).retrieveFromKey(avatarId);
    final UserJsonDataProvider userProvider = Provider.of<UserJsonDataProvider>(
      context,
    );

    return FutureBuilder<User?>(
      future: userProvider.readData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else if (snapshot.hasError) {
          return const Icon(Icons.error);
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Icon(Icons.person);
        }

        final user = snapshot.data!;
        final int userAvatarId = user.avatarCode;

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
            onTap: () {
              _onTap(context, user, avatarId);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(user.bgColorCode),
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
      },
    );
  }
}
