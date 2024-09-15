import 'package:flashcard_pets/widgets/avatar_thumb.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_fab.dart';
import 'package:flutter/material.dart';

class ChangeAvatarScreen extends StatelessWidget {
  //Mocked data
  final List<int> _avatars = [1, 2, 3, 4, 5];
  ChangeAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;

    return Scaffold(
      appBar: const ThemedAppBar("Mudar Avatar"),
      body: ScreenLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Escolha um avatar da coleção para personalizar seu perfil.",
              style: body,
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: GridView.extent(
                maxCrossAxisExtent: 120.0,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                children: _avatars.map((int avatar) {
                  return const AvatarThumb();
                }).toList(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: ThemedFab(
        () {
          Navigator.of(context).pop();
        },
        const Icon(Icons.check),
      ),
    );
  }
}
