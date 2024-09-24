import 'package:flashcard_pets/models/award.dart';
import 'package:flashcard_pets/providers/constants/i_data_provider.dart';
import 'package:flutter/material.dart';

class AwardDataProvider with ChangeNotifier implements IDataProvider<Award> {
  final Map<int, Award> _data = {
    0: Award(
      AwardCategory.cards,
      "assets/images/awards/reviews/reviewer_i.png",
      "Revisor I",
      "Revise 10 cartões.",
      10,
      50,
    ),
    1: Award(
      AwardCategory.cards,
      "assets/images/awards/reviews/reviewer_ii.png",
      "Revisor II",
      "Revise 300 cartões.",
      300,
      300,
    ),
    2: Award(
      AwardCategory.cards,
      "assets/images/awards/reviews/reviewer_iii.png",
      "Revisor III",
      "Revise 1000 cartões.",
      1000,
      1000,
    ),
    3: Award(
      AwardCategory.cards,
      "assets/images/awards/reviews/streak_i.png",
      "Focado I",
      "Faça suas revisões por 7 dias consecutivos.",
      7,
      150,
    ),
    4: Award(
      AwardCategory.cards,
      "assets/images/awards/reviews/streak_ii.png",
      "Focado II",
      "Faça suas revisões por 28 dias consecutivos.",
      28,
      300,
    ),
    5: Award(
      AwardCategory.cards,
      "assets/images/awards/reviews/streak_iii.png",
      "Focado III",
      "Faça suas revisões por 100 dias consecutivos.",
      100,
      1000,
    ),
    6: Award(
      AwardCategory.cards,
      "assets/images/awards/reviews/bullseye_i.png",
      "Na mosca! I",
      "Avalie 10 revisões com nota máxima.",
      10,
      50,
    ),
    7: Award(
      AwardCategory.cards,
      "assets/images/awards/reviews/bullseye_ii.png",
      "Na mosca! II",
      "Avalie 50 revisões com nota máxima.",
      50,
      200,
    ),
    8: Award(
      AwardCategory.cards,
      "assets/images/awards/reviews/bullseye_iii.png",
      "Na mosca! III",
      "Avalie 100 revisões com nota máxima.",
      100,
      500,
    ),
    9: Award(
      AwardCategory.cards,
      "assets/images/awards/reviews/card_collector_i.png",
      "Coletor de Cartas I",
      "Registre 10 cartões.",
      10,
      50,
    ),
    10: Award(
      AwardCategory.cards,
      "assets/images/awards/reviews/card_collector_ii.png",
      "Coletor de Cartas  II",
      "Registre 100 cartões.",
      100,
      200,
    ),
    11: Award(
      AwardCategory.cards,
      "assets/images/awards/reviews/card_collector_iii.png",
      "Coletor de Cartas  III",
      "Registre 300 cartões.",
      300,
      500,
    ),
    12: Award(
      AwardCategory.pets,
      "assets/images/awards/pets/pet_lover_i.png",
      "Amante de Pets I",
      "Adote 4 pets.",
      3,
      100,
    ),
    13: Award(
      AwardCategory.pets,
      "assets/images/awards/pets/pet_lover_ii.png",
      "Amante de Pets II",
      "Adote 8 pets.",
      10,
      300,
    ),
    14: Award(
      AwardCategory.pets,
      "assets/images/awards/pets/pet_lover_iii.png",
      "Amante de Pets III",
      "Adote 16 pets.",
      20,
      1000,
    ),
    15: Award(
      AwardCategory.pets,
      "assets/images/awards/pets/trainer_i.png",
      "Treinador I",
      "Tenha um pet nível 5 ou maior.",
      5,
      100,
    ),
    16: Award(
      AwardCategory.pets,
      "assets/images/awards/pets/trainer_ii.png",
      "Treinador II",
      "Tenha um pet nível 25 ou maior.",
      25,
      300,
    ),
    17: Award(
      AwardCategory.pets,
      "assets/images/awards/pets/trainer_iii.png",
      "Treinador III",
      "Tenha um pet nível 50.",
      50,
      1000,
    ),
    18: Award(
      AwardCategory.pets,
      "assets/images/awards/pets/seeing_stars_i.png",
      "Vendo Estrelas I",
      "Tenha um pet com 1 ou mais estrelas.",
      1,
      100,
    ),
    19: Award(
      AwardCategory.pets,
      "assets/images/awards/pets/seeing_stars_ii.png",
      "Vendo Estrelas II",
      "Tenha um pet com 3 ou mais estrelas.",
      3,
      300,
    ),
    20: Award(
      AwardCategory.pets,
      "assets/images/awards/pets/seeing_stars_iii.png",
      "Vendo Estrelas III",
      "Tenha um pet com 5 estrelas.",
      5,
      500,
    ),
    21: Award(
      AwardCategory.social,
      "assets/images/awards/social/popular_i.png",
      "Popular I",
      "Adicione 1 amigo.",
      1,
      50,
    ),
    22: Award(
      AwardCategory.social,
      "assets/images/awards/social/popular_ii.png",
      "Popular II",
      "Adicione 5 amigo.",
      5,
      75,
    ),
    23: Award(
      AwardCategory.social,
      "assets/images/awards/social/popular_iii.png",
      "Popular III",
      "Adicione 10 amigo.",
      10,
      100,
    ),
    24: Award(
      AwardCategory.social,
      "assets/images/awards/social/just_a_gift_i.png",
      "Só uma Lembrancinha I",
      "Presenteie um amigo 1 vez.",
      1,
      50,
    ),
    25: Award(
      AwardCategory.social,
      "assets/images/awards/social/just_a_gift_ii.png",
      "Só uma Lembrancinha II",
      "Presenteie um amigo 20 vezes.",
      20,
      100,
    ),
    26: Award(
      AwardCategory.social,
      "assets/images/awards/social/just_a_gift_iii.png",
      "Só uma Lembrancinha III",
      "Presenteie um amigo 100 vezes.",
      100,
      300,
    ),
    27: Award(
      AwardCategory.social,
      "assets/images/awards/social/competitor.png",
      "Competidor",
      "Consiga um lugar no top 10 do ranking semanal geral.",
      1,
      500,
    ),
  };

  @override
  Map<int, Award> retrieveData() {
    return _data;
  }

  @override
  Award retrieveFromKey(int key) {
    return _data[key] ?? _data[0]!;
  }
}