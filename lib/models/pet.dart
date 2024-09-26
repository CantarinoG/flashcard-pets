class Pet {
  String id;
  int petBioCode;
  String? name;
  int stars;
  int totalCopies;
  int currentCopies;
  int nextStarCopies;
  int totalXp;
  int currentXp;
  int nextLevelXp;
  int level;
  int totalGoldSpent;

  Pet(this.id, this.petBioCode,
      {this.name,
      this.stars = 0,
      this.totalCopies = 0,
      this.currentCopies = 0,
      this.nextStarCopies = 1,
      this.totalXp = 0,
      this.currentXp = 0,
      this.nextLevelXp = 50,
      this.level = 1,
      this.totalGoldSpent = 0});
}
