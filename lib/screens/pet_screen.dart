import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/pet_description_card.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';

class PetScreen extends StatelessWidget {
  //Mocked data
  final String _imgPath = "assets/images/baby_pets/beagle.png";
  final String _name = "Cleitinho";
  final int _level = 5;
  final int _currentXp = 450;
  final int _goalXp = 500;
  final String _description =
      "Cleitinho é um cachorro muito bacana e fiel. Sempre diposto a ajudar seu dono.";
  final String _age = "Filhote";
  final String _breed = "Beagle";
  final String _likes = "Perserguir esquilos, comer pestiscos.";
  final String _dislikes = "Tomar banho, barulhos.";
  final int _skillValue = 2;
  final String _skillDesc = "% mais ouro ao revisar cartões.";
  const PetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double progress = _currentXp / _goalXp;

    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;

    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color bright = Theme.of(context).colorScheme.bright;

    return Scaffold(
      appBar: ThemedAppBar(
        "Pets",
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: ScreenLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                _imgPath,
                fit: BoxFit
                    .cover, // Ensures the image fits nicely within the circular shape
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _name,
                  style: h2?.copyWith(
                    color: secondary,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  color: bright,
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Lvl $_level",
                style: h3,
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                  colors: [
                    primary,
                    secondary,
                    const Color.fromARGB(255, 201, 201, 201),
                  ],
                  stops: [
                    progress / 2,
                    progress,
                    progress,
                  ],
                ),
              ),
              child: const SizedBox(height: 8),
            ),
            SizedBox(
              width: double.infinity,
              child: RichText(
                textAlign: TextAlign.end,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "XP",
                      style: h4.copyWith(
                        color: secondary,
                      ),
                    ),
                    TextSpan(
                      text: " $_currentXp/$_goalXp",
                      style: body?.copyWith(
                        color: secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ThemedFilledButton(label: "Alimentar", onPressed: () {}),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PetDescriptionCard(
                      iconData: Icons.star,
                      title: "Habilidade",
                      content: "$_skillValue$_skillDesc",
                    ),
                    PetDescriptionCard(
                      iconData: Icons.description,
                      title: "Descrição",
                      content: _description,
                    ),
                    PetDescriptionCard(
                      iconData: Icons.calendar_month,
                      title: "Idade",
                      content: _age,
                    ),
                    PetDescriptionCard(
                      iconData: Icons.pets,
                      title: "Raça",
                      content: _breed,
                    ),
                    PetDescriptionCard(
                      iconData: Icons.sentiment_satisfied_outlined,
                      title: "Gosta de",
                      content: _likes,
                    ),
                    PetDescriptionCard(
                      iconData: Icons.sentiment_dissatisfied,
                      title: "Não gosta de",
                      content: _dislikes,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
