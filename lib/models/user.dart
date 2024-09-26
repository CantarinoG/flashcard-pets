class User {
  int level;
  int gold;
  int totalXp;
  int currentLevelXp;
  int nextLevelXp;

  User({
    this.level = 1,
    this.gold = 100,
    this.totalXp = 0,
    this.currentLevelXp = 0,
    this.nextLevelXp = 50,
  });

  static User fromMap(Map<String, dynamic> map) {
    return User(
      level: map["level"],
      gold: map["gold"],
      totalXp: map["totalXp"],
      currentLevelXp: map["currentLevelXp"],
      nextLevelXp: map["nextLevelXp"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "level": level,
      "gold": gold,
      "totalXp": totalXp,
      "currentLevelXp": currentLevelXp,
      "nextLevelXp": nextLevelXp,
    };
  }
}
