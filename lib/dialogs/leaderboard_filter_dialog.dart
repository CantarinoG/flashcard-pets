import 'package:flutter/material.dart';

class LeaderboardFilterDialog extends StatelessWidget {
  final String _title;
  const LeaderboardFilterDialog(this._title, {super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    //final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    //final Color warning = Theme.of(context).colorScheme.warning;

    return AlertDialog(
      title: Text(
        _title,
        style: h2?.copyWith(
          color: secondary,
        ),
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [],
      ),
    );
  }
}
