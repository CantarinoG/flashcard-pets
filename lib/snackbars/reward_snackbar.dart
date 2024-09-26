import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RewardSnackbar extends StatelessWidget {
  final int goldValue;
  final int xpValue;
  const RewardSnackbar(this.goldValue, this.xpValue, {super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Obteve:",
          style: body?.copyWith(
            color: primary,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        SvgPicture.asset(
          "assets/images/custom_icons/coin.svg",
          width: 30,
          height: 30,
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          " $goldValue",
          style: body?.copyWith(color: primary),
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          "XP",
          style: h4.copyWith(
            color: secondary,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          " $xpValue",
          style: body?.copyWith(
            color: primary,
          ),
        ),
      ],
    );
  }
}
