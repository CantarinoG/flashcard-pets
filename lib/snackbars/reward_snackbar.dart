import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RewardSnackbar extends StatelessWidget {
  final int goldValue;
  final int xpValue;
  final String? optionalMessage;
  const RewardSnackbar(this.goldValue, this.xpValue,
      {super.key, this.optionalMessage});

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (optionalMessage != null)
          Flexible(
            child: Text(
              optionalMessage!,
              style: body,
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        const SizedBox(
          height: 16,
        ),
        Row(
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
            if (goldValue > 0) ...[
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
            ],
            if (xpValue > 0) ...[
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
          ],
        ),
      ],
    );
  }
}
