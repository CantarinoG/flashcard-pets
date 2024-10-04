import 'package:flashcard_pets/providers/constants/avatar_data_provider.dart';
import 'package:flashcard_pets/providers/services/firebase_auth_provider.dart';
import 'package:flashcard_pets/providers/services/sync_provider.dart';
import 'package:flashcard_pets/providers/services/firebase_social_provider.dart';
import 'package:flashcard_pets/screens/user_profile_screen.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FriendCard extends StatelessWidget {
  final String friendId;
  const FriendCard({required this.friendId, super.key});

  void _visitFriendProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileScreen(),
      ),
    );
  }

  void _sendGift(BuildContext context) async {
    final String ownUserId =
        Provider.of<FirebaseAuthProvider>(context, listen: false).uid!;
    final result =
        await Provider.of<FirebaseSocialProvider>(context, listen: false)
            .sendGift(ownUserId, friendId);
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color brightColor = Theme.of(context).colorScheme.bright;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color disabled = Theme.of(context).disabledColor;

    final String ownUserId =
        Provider.of<FirebaseAuthProvider>(context, listen: false).uid!;

    return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        Provider.of<SyncProvider>(context, listen: false).getUserData(friendId),
        Provider.of<FirebaseSocialProvider>(context)
            .canSendGift(ownUserId, friendId),
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar dados do amigo'));
        } else if (!snapshot.hasData || snapshot.data![0] == null) {
          return const Center(child: Text('Dados do amigo não encontrados'));
        }

        final userData = snapshot.data![0] as Map<String, dynamic>;
        final bool canSendGift = snapshot.data![1] as bool;
        final String name = userData['name'] ?? 'Usuário';
        final int avatarCode = userData['avatarCode'] ?? 0;
        final int bgColorCode = userData['bgColorCode'] ?? 0xFFFFFFFF;

        final String avatarPath = Provider.of<AvatarDataProvider>(context)
            .retrieveFromKey(avatarCode);

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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(bgColorCode),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          avatarPath,
                          fit: BoxFit.cover,
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
                            "id $friendId",
                            style: body?.copyWith(color: disabled),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton.filled(
                    onPressed: canSendGift ? () => _sendGift(context) : null,
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
      },
    );
  }
}
