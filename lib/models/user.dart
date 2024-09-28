class User {
  int level;
  int gold;
  int totalXp;
  int currentLevelXp;
  int nextLevelXp;
  int bgColorCode;
  int avatarCode;
  String name;
  bool darkMode;

  User({
    this.level = 1,
    this.gold = 100,
    this.totalXp = 0,
    this.currentLevelXp = 0,
    this.nextLevelXp = 50,
    this.bgColorCode = 0xFF5C9EAD,
    this.avatarCode = 0,
    this.name = "Usuário",
    this.darkMode = false,
  });

  static User fromMap(Map<String, dynamic> map) {
    return User(
      level: map["level"],
      gold: map["gold"],
      totalXp: map["totalXp"],
      currentLevelXp: map["currentLevelXp"],
      nextLevelXp: map["nextLevelXp"],
      bgColorCode: map["bgColorCode"],
      avatarCode: map["avatarCode"],
      name: map["name"],
      darkMode: map["darkMode"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "level": level,
      "gold": gold,
      "totalXp": totalXp,
      "currentLevelXp": currentLevelXp,
      "nextLevelXp": nextLevelXp,
      "bgColorCode": bgColorCode,
      "avatarCode": avatarCode,
      "name": name,
      "darkMode": darkMode,
    };
  }
}
