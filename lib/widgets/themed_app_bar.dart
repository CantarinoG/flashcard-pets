import 'package:flutter/material.dart';

class ThemedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const ThemedAppBar(this.title, {this.actions, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    TextStyle? h1 = Theme.of(context).textTheme.headlineLarge;
    Color primary = Theme.of(context).colorScheme.primary;
    Color secondary = Theme.of(context).colorScheme.secondary;

    return AppBar(
      title: Text(
        title,
        style: h1?.copyWith(color: secondary),
      ),
      centerTitle: true,
      actionsIconTheme: IconThemeData(
        color: primary,
      ),
      actions: actions,
    );
  }
}
