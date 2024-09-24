import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class ThemedFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? width;
  final bool isBold;
  const ThemedFilledButton(
      {required this.label,
      required this.onPressed,
      this.width,
      this.leadingIcon,
      this.trailingIcon,
      this.isBold = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color disabled = Theme.of(context).disabledColor;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;

    return SizedBox(
      width: width,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return disabled;
            }
            return primary;
          }),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leadingIcon != null) leadingIcon!,
            const SizedBox(
              width: 2,
            ),
            Text(
              label,
              style: bodyEm.copyWith(
                  fontWeight: !isBold ? FontWeight.normal : FontWeight.bold),
            ),
            const SizedBox(
              width: 2,
            ),
            if (trailingIcon != null) trailingIcon!,
          ],
        ),
      ),
    );
  }
}
