import 'package:flutter/material.dart';

class ScreenLayout extends StatelessWidget {
  final Widget child;

  const ScreenLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          child: child,
        ),
      ),
    );
  }
}
