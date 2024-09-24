import 'package:flashcard_pets/models/pet_bio.dart';
import 'package:flashcard_pets/providers/constants/i_data_provider.dart';
import 'package:flutter/material.dart';

class PetBioDataProvider with ChangeNotifier implements IDataProvider<PetBio> {
  final Map<int, PetBio> _data = {
    0: const PetBio(
      "Labrador Retriever",
      "assets/images/baby_pets/labrador_retriever.png",
      "assets/images/adult_pets/labrador_retriever.png",
      "Amigáveis e extrovertidos, os labradores são ótimos animais de estimação para a família.",
      "Água, buscar objetos e brincar com crianças.",
      "Ficar sozinho por longos períodos.",
      PetSkill.betterPets,
      PetRarity.common,
    ),
    1: const PetBio(
      "Beagle",
      "assets/images/baby_pets/beagle.png",
      "assets/images/adult_pets/beagle.png",
      "Curiosos e amigáveis, os beagles são ótimos companheiros.",
      "Farejar e aventuras ao ar livre.",
      "Ficar preso dentro de casa por muito tempo.",
      PetSkill.cheaperUpgrade,
      PetRarity.common,
    ),
    2: const PetBio(
      "Poodle",
      "assets/images/baby_pets/poodle.png",
      "assets/images/adult_pets/poodle.png",
      "Elegante e altamente inteligente, o poodle é conhecido por sua versatilidade e facilidade em aprender comandos.",
      "Aprender truques, nadar.",
      "Calor excessivo.",
      PetSkill.moreGold,
      PetRarity.common,
    ),
    3: const PetBio(
      "Golden Retriever",
      "assets/images/baby_pets/golden_retriever.png",
      "assets/images/adult_pets/golden_retriever.png",
      "Leais e inteligentes, os golden retrievers são excelentes cães de família.",
      "Buscar objetos, nadar e estar com pessoas.",
      "Ficar sozinho.",
      PetSkill.moreXp,
      PetRarity.common,
    ),
    4: const PetBio(
      "Bulldog Francês",
      "assets/images/baby_pets/french_bulldog.png",
      "assets/images/adult_pets/french_bulldog.png",
      "Brincalhões e adaptáveis, são ótimos para apartamentos.",
      "Relaxar e receber carinho.",
      "Temperaturas extremas.",
      PetSkill.betterPets,
      PetRarity.uncommon,
    ),
    5: const PetBio(
      "Cocker Spaniel",
      "assets/images/baby_pets/cocker_spaniel.png",
      "assets/images/adult_pets/cocker_spaniel.png",
      "Gentis e amorosos, ótimos com crianças.",
      "Hora de brincar e socializar.",
      "Métodos de treinamento duros.",
      PetSkill.cheaperUpgrade,
      PetRarity.uncommon,
    ),
    6: const PetBio(
      "Shetland Sheepdog",
      "assets/images/baby_pets/shetland_sheepdog.png",
      "assets/images/adult_pets/shetland_sheepdog.png",
      "Inteligentes e enérgicos, os shelties são ótimos pastores.",
      "Correr e brincar de buscar.",
      "Ser deixado de fora das atividades familiares.",
      PetSkill.moreGold,
      PetRarity.uncommon,
    ),
    7: const PetBio(
      "Dálmata",
      "assets/images/baby_pets/dalmatian.png",
      "assets/images/adult_pets/dalmatian.png",
      "Ativos e brincalhões, conhecidos por suas manchas únicas.",
      "Correr e atividades ao ar livre.",
      "Ficar preso em casa.",
      PetSkill.moreXp,
      PetRarity.uncommon,
    ),
    8: const PetBio(
      "Whippet",
      "assets/images/baby_pets/whippet.png",
      "assets/images/adult_pets/whippet.png",
      "Quietos e gentis, os whippets são surpreendentemente rápidos.",
      "Corridas curtas e carinho.",
      "Ambientes barulhentos.",
      PetSkill.betterPets,
      PetRarity.rare,
    ),
    9: const PetBio(
      "Shiba Inu",
      "assets/images/baby_pets/shiba_inu.png",
      "assets/images/adult_pets/shiba_inu.png",
      "Independentes e espirituosos, os shibas são conhecidos por sua aparência de raposa.",
      "Explorar e ser ativo.",
      "Ser mandado.",
      PetSkill.cheaperUpgrade,
      PetRarity.rare,
    ),
    10: const PetBio(
      "Cão d'Água Português",
      "assets/images/baby_pets/portuguese_water_dog.png",
      "assets/images/adult_pets/portuguese_water_dog.png",
      "Energéticos e amigáveis, esses cães amam a água.",
      "Nadar e buscar objetos.",
      "Ficar inativo.",
      PetSkill.moreGold,
      PetRarity.rare,
    ),
    11: const PetBio(
      "Boiadeiro de Berna",
      "assets/images/baby_pets/bernese_mountain_dog.png",
      "assets/images/adult_pets/bernese_mountain_dog.png",
      "Gigantes gentis, ótimos com famílias e crianças.",
      "Estar ao ar livre e fazer trilhas.",
      "Ficar sozinho por longos períodos.",
      PetSkill.moreXp,
      PetRarity.rare,
    ),
    12: const PetBio(
      "Airedale Terrier",
      "assets/images/baby_pets/airedale_terrier.png",
      "assets/images/adult_pets/airedale_terrier.png",
      "O maior dos terriers, conhecidos por sua inteligência e versatilidade.",
      "Engajar-se em atividades e ser treinado.",
      "Tédio",
      PetSkill.betterPets,
      PetRarity.epic,
    ),
    13: const PetBio(
      "Mastiff",
      "assets/images/baby_pets/mastiff.png",
      "assets/images/adult_pets/mastiff.png",
      "Massivos e gentis, ótimos protetores.",
      "Cochilar e estar com a família.",
      "Ser assustado.",
      PetSkill.cheaperUpgrade,
      PetRarity.epic,
    ),
    14: const PetBio(
      "Saluki",
      "assets/images/baby_pets/saluki.png",
      "assets/images/adult_pets/saluki.png",
      "Elegantes e atléticos, conhecidos por sua velocidade.",
      "Correr e espaços abertos.",
      "Ficar confinado.",
      PetSkill.moreGold,
      PetRarity.epic,
    ),
    15: const PetBio(
      "Dogo Argentino",
      "assets/images/baby_pets/dogo_argentino.png",
      "assets/images/adult_pets/dogo_argentino.png",
      "Fortes e corajosos, originalmente criados para caçar grandes animais.",
      "Atividades físicas e companhia.",
      "Isolamento da família.",
      PetSkill.moreXp,
      PetRarity.epic,
    ),
  };

  @override
  Map<int, PetBio> retrieveData() {
    return _data;
  }

  @override
  PetBio retrieveFromKey(int key) {
    return _data[key] ?? _data[0]!;
  }
}