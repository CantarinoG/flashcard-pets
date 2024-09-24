import 'package:flutter/material.dart';

class ThemedFab extends StatelessWidget {
  final void Function()? _onPressed;
  final Icon _fabIcon;
  const ThemedFab(this._onPressed, this._fabIcon, {super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return FloatingActionButton(
      onPressed: _onPressed,
      shape: const CircleBorder(),
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
      splashColor: secondaryColor,
      child: _fabIcon,
    );
  }
}
