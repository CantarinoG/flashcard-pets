import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/constants/i_data_provider.dart';
import 'package:flashcard_pets/providers/services/i_json_data_provider.dart';
import 'package:flashcard_pets/widgets/avatar_thumb.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeAvatarScreen extends StatelessWidget {
  final List<int> _availableColors = [
    0xFF5C9EAD,
    0xFFFFC1C1,
    0xFF98FF98,
    0xFFB39BC8,
    0xFFF9D342,
    0xFFFF6F61,
    0xFFF5E8C7,
    0xFFB0BEC5,
  ];
  ChangeAvatarScreen({super.key});

  void _confirm(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _changeBgColor(BuildContext context, int colorValue) async {
    final IJsonDataProvider<User> userProvider =
        Provider.of<IJsonDataProvider<User>>(
      context,
      listen: false,
    );
    final User? user = await userProvider.readData();
    if (user != null) {
      user.bgColorCode = colorValue;
      userProvider.writeData(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;

    final Color secondary = Theme.of(context).colorScheme.secondary;

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
            SizedBox(
              width: double.infinity,
              child: Text(
                "Cor de Fundo",
                style: h3?.copyWith(
                  color: secondary,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _availableColors.map((int colorValue) {
                  return InkWell(
                    onTap: () {
                      _changeBgColor(context, colorValue);
                    },
                    radius: 15,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(colorValue),
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Avatar",
                style: h3?.copyWith(
                  color: secondary,
                ),
              ),
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
