import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GiftNotification extends StatelessWidget {
  //Mocked data
  final String _imgPath = "assets/images/baby_pets/beagle.png";
  final String _userName = "CantarinoG";
  final int _moneyReceived = 25;
  const GiftNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(),
        const SizedBox(
          height: 16,
        ),
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
        const SizedBox(
          height: 8,
        ),
        Text(
          "$_userName te enviou um presente:",
          style: bodyEm,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/icons/coin.svg",
              width: 30,
              height: 30,
            ),
            Text(
              "$_moneyReceived",
              style: bodyEm,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
