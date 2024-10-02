import 'package:flutter/material.dart';

class MediaThumbAudio extends StatelessWidget {
  final String base64AudioString;
  const MediaThumbAudio(this.base64AudioString, {super.key});

  void _onTap() {}

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;

    return Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: primary,
            width: 2,
          ),
        ),
        child: IconButton(
          icon: const Icon(Icons.mic),
          color: Colors.white,
          onPressed: _onTap,
        ));
  }
}
