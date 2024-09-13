import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flutter/material.dart';

class ChangeAvatarScreen extends StatelessWidget {
  const ChangeAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ThemedAppBar("Mudar Avatar"),
      body: ScreenLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}