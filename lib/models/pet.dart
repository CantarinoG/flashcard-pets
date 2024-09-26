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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'petBioCode': petBioCode,
      'name': name,
      'stars': stars,
      'totalCopies': totalCopies,
      'currentCopies': currentCopies,
      'nextStarCopies': nextStarCopies,
      'totalXp': totalXp,
      'currentXp': currentXp,
      'nextLevelXp': nextLevelXp,
      'level': level,
      'totalGoldSpent': totalGoldSpent,
    };
  }

  static Pet fromMap(Map<String, dynamic> map) {
    return Pet(
      map['id'],
      map['petBioCode'],
      name: map['name'],
      stars: map['stars'] ?? 0,
      totalCopies: map['totalCopies'] ?? 0,
      currentCopies: map['currentCopies'] ?? 0,
      nextStarCopies: map['nextStarCopies'] ?? 1,
      totalXp: map['totalXp'] ?? 0,
      currentXp: map['currentXp'] ?? 0,
      nextLevelXp: map['nextLevelXp'] ?? 50,
      level: map['level'] ?? 1,
      totalGoldSpent: map['totalGoldSpent'] ?? 0,
    );
  }
}
