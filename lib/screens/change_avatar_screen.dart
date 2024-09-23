import 'package:flashcard_pets/data_providers/i_data_provider.dart';
import 'package:flashcard_pets/widgets/avatar_thumb.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeAvatarScreen extends StatelessWidget {
  const ChangeAvatarScreen({super.key});

  void _confirm(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;

    final Map<int, String> avatars =
        Provider.of<IDataProvider<String>>(context).retrieveData();

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
                children: avatars.keys.map((int id) {
                  return AvatarThumb(id);
                }).toList(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: ThemedFab(
        () {
          _confirm(context);
        },
        const Icon(Icons.check),
      ),
    );
  }
}
