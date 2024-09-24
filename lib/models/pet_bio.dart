enum PetRarity {
  common,
  uncommon,
  rare,
  epic,
}

enum PetSkill {
  moreGold,
  moreXp,
  betterPets,
  cheaperUpgrade,
}

class PetBio {
  final String babyPic;
  final String adultPic;
  final String breed;
  final String description;
  final String likes;
  final String dislikes;
  final PetSkill skill;
  final PetRarity rarity;

  const PetBio(
    this.breed,
    this.babyPic,
    this.adultPic,
    this.description,
    this.likes,
    this.dislikes,
    this.skill,
    this.rarity,
  );
}
