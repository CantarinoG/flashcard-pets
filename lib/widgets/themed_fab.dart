import 'package:flutter/material.dart';

class ThemedFab extends StatelessWidget {
  final void Function()? _onPressed;
  final Icon _fabIcon;
  const ThemedFab(this._onPressed, this._fabIcon, {super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    Color backgroundColor = Theme.of(context).colorScheme.surface;

    return FloatingActionButton(
      onPressed: _onPressed,
      shape: const CircleBorder(),
      foregroundColor: backgroundColor,
      backgroundColor: primaryColor,
      splashColor: secondaryColor,
      child: _fabIcon,
    );
  }
}
