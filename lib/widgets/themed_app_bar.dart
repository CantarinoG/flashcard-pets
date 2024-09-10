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
    Color background = Theme.of(context).colorScheme.surface;

    return AppBar(
      title: Text(
        title,
        style: h1?.copyWith(color: secondary),
      ),
      iconTheme: IconThemeData(
        color: primary,
      ),
      backgroundColor: background,
      scrolledUnderElevation: 0,
      centerTitle: true,
      actionsIconTheme: IconThemeData(
        color: primary,
      ),
      actions: actions,
    );
  }
}
