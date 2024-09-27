import 'package:flashcard_pets/dialogs/feed_pet_dialog.dart';
import 'package:flashcard_pets/dialogs/single_input_dialog.dart';
import 'package:flashcard_pets/models/pet.dart';
import 'package:flashcard_pets/models/pet_bio.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/constants/i_data_provider.dart';
import 'package:flashcard_pets/providers/dao/i_dao.dart';
import 'package:flashcard_pets/providers/services/i_game_elements_calculations.dart';
import 'package:flashcard_pets/providers/services/i_json_data_provider.dart';
import 'package:flashcard_pets/themes/app_text_styles.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flashcard_pets/widgets/no_items_placeholder.dart';
import 'package:flashcard_pets/widgets/pet_description_card.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/stars.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PetScreen extends StatefulWidget {
  final Pet pet;

  const PetScreen(this.pet, {super.key});

  @override
  State<PetScreen> createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  //Mocked data
  final int _skillValue = 2;
  final String _skillDesc = "% mais ouro ao revisar cartões.";

  void _sell() {
    debugPrint("Aquiii ${widget.pet.totalGoldSpent}");
  }

  void _changeName(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SingleInputDialog<String>(
          title: "Mudar o Nome do Pet",
          description: "Insira o novo nome do pet.",
          label: "Nome",
        );
      },
    ).then((value) {
      if (value != null && value.isNotEmpty) {
        widget.pet.name = value;
        final petDao = Provider.of<IDao<Pet>>(context, listen: false);
        petDao.update(widget.pet);
        setState(() {});
      }
    });
  }

  void _feed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FeedPetDialog(widget.pet);
      },
    ).then((value) {
      if (value == null) return;
      final gameElementsCalculator =
          Provider.of<IGameElementsCalculations>(context, listen: false);
      if (!mounted) return;
      final updatedPet =
          gameElementsCalculator.addPetXp(widget.pet, value, context);
      final petDao = Provider.of<IDao<Pet>>(context, listen: false);
      petDao.update(updatedPet);

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final TextStyle? h2 = Theme.of(context).textTheme.headlineMedium;
    final TextStyle? h3 = Theme.of(context).textTheme.headlineSmall;
    final TextStyle h4 = Theme.of(context).textTheme.headlineSmallEm;
    final TextStyle bodyEm = Theme.of(context).textTheme.bodySmallEm;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color bright = Theme.of(context).colorScheme.bright;
    final Color star = Theme.of(context).colorScheme.star;
    final Color starLighter = Theme.of(context).colorScheme.starLighter;
    final Color text = Theme.of(context).colorScheme.text;
    final Color warning = Theme.of(context).colorScheme.warning;

    final petBio = Provider.of<IDataProvider<PetBio>>(context)
        .retrieveFromKey(widget.pet.petBioCode);

    final double xpProgress = widget.pet.currentXp / widget.pet.nextLevelXp;
    final double copiesProgress =
        widget.pet.currentCopies / widget.pet.nextStarCopies;
    return Scaffold(
      appBar: ThemedAppBar(
        "Pets",
        actions: [
          IconButton(
            onPressed: _sell,
            icon: const Icon(Icons.attach_money),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<IJsonDataProvider<User>>(context, listen: false)
            .readData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else if (snapshot.hasError) {
            return NoItemsPlaceholder('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const NoItemsPlaceholder('No user data available');
          }

          final user = snapshot.data!;

          return ScreenLayout(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      (widget.pet.level < 10)
                          ? petBio.babyPic
                          : petBio.adultPic,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.pet.name ?? petBio.breed,
                        style: h2?.copyWith(color: secondary),
                      ),
                      const SizedBox(width: 4),
                      IconButton.filled(
                        onPressed: () => _changeName(context),
                        icon: const Icon(Icons.edit),
                        color: bright,
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Stars(widget.pet.stars),
                  if (widget.pet.stars < 5) ...[
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          colors: [
                            starLighter,
                            star,
                            const Color.fromARGB(255, 201, 201, 201),
                          ],
                          stops: [
                            copiesProgress / 2,
                            copiesProgress,
                            copiesProgress,
                          ],
                        ),
                      ),
                      child: const SizedBox(height: 8),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.copy, color: secondary),
                          Text(
                            " ${widget.pet.currentCopies}/${widget.pet.nextStarCopies}",
                            style: body?.copyWith(color: secondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Lvl ',
                            style: h4.copyWith(color: secondary),
                          ),
                          TextSpan(
                            text: '${widget.pet.level}',
                            style: h3,
                          ),
                        ],
                      ),
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
                          xpProgress / 2,
                          xpProgress,
                          xpProgress,
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
                            style: h4.copyWith(color: secondary),
                          ),
                          TextSpan(
                            text:
                                " ${widget.pet.currentXp}/${widget.pet.nextLevelXp}",
                            style: body?.copyWith(color: secondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ThemedFilledButton(
                    label: "Alimentar",
                    onPressed: (widget.pet.level >= user.level)
                        ? null
                        : () => _feed(context),
                  ),
                  if (widget.pet.level >= user.level) ...[
                    Text(
                      "O nível do pet não pode ser maior que o nível do usuário.",
                      style: bodyEm.copyWith(
                        color: warning,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                  const SizedBox(height: 8),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PetDescriptionCard(
                        iconData: Icons.auto_awesome,
                        title: "Habilidade",
                        content: "$_skillValue$_skillDesc",
                      ),
                      PetDescriptionCard(
                        iconData: Icons.diamond,
                        title: "Raridade",
                        content: "",
                        color: text,
                        rarity: petBio.rarity,
                      ),
                      PetDescriptionCard(
                        iconData: Icons.pets,
                        title: "Raça",
                        content: petBio.breed,
                      ),
                      PetDescriptionCard(
                        iconData: Icons.description,
                        title: "Descrição",
                        content: petBio.description,
                      ),
                      PetDescriptionCard(
                        iconData: Icons.calendar_month,
                        title: "Idade",
                        content: (widget.pet.level < 10) ? "Filhote" : "Adulto",
                      ),
                      PetDescriptionCard(
                        iconData: Icons.sentiment_satisfied_outlined,
                        title: "Gosta de",
                        content: petBio.likes,
                      ),
                      PetDescriptionCard(
                        iconData: Icons.sentiment_dissatisfied,
                        title: "Não gosta de",
                        content: petBio.dislikes,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
