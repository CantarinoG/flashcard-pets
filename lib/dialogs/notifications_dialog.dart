import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/services/user_json_data_provider.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flashcard_pets/providers/services/firebase_auth_provider.dart';
import 'package:flashcard_pets/providers/services/firebase_social_provider.dart';

class NotificationsDialog extends StatelessWidget {
  NotificationsDialog({super.key});

  void _goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _receiveAll(BuildContext context, int giftValue, String userId) async {
    await Provider.of<FirebaseSocialProvider>(context, listen: false)
        .receiveGifts(userId);

    final UserJsonDataProvider userProvider =
        Provider.of<UserJsonDataProvider>(context, listen: false);
    final User? user = await userProvider.readData();
    user!.gold += giftValue;
    user.totalGoldEarned += giftValue;
    await userProvider.writeData(user);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final String userId =
        Provider.of<FirebaseAuthProvider>(context, listen: false).uid!;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color textColor = Theme.of(context).colorScheme.text;

    return AlertDialog(
      content: FutureBuilder<int?>(
        future: Provider.of<FirebaseSocialProvider>(context, listen: false)
            .checkReceivedGifts(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final int giftValue = snapshot.data ?? 0;

            return (giftValue == 0)
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Sem notificações...",
                          style: body?.copyWith(color: textColor)),
                      SizedBox(
                        height: 8,
                      ),
                      ThemedFilledButton(
                          label: "Voltar",
                          onPressed: () {
                            _goBack(context);
                          })
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Você recebeu presentes de seus amigos...",
                          style: body?.copyWith(color: textColor)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/custom_icons/coin.svg",
                            width: 30,
                            height: 30,
                          ),
                          Text(
                            "$giftValue",
                            style: body,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ThemedFilledButton(
                          label: "Coletar",
                          onPressed: () {
                            _receiveAll(context, giftValue, userId);
                          })
                    ],
                  );
          }
        },
      ),
    );
  }
}
