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
  int totalReviewedCards;
  int totalRightCardsReviewed;
  int streak;
  DateTime? lastTimeUsedApp;
  int highestStreak;
  DateTime? dayCreated;
  int createdCollections;
  int createdCards;
  int totalGoldEarned;
  int totalGoldSpent;
  int totalPetXp;
  int totalGoldFromRevisions;
  int totalXpFromRevisions;

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
    this.totalReviewedCards = 0,
    this.totalRightCardsReviewed = 0,
    this.streak = 1,
    this.lastTimeUsedApp,
    this.highestStreak = 1,
    this.dayCreated,
    this.createdCollections = 0,
    this.createdCards = 0,
    this.totalGoldEarned = 0,
    this.totalGoldSpent = 0,
    this.totalPetXp = 0,
    this.totalGoldFromRevisions = 0,
    this.totalXpFromRevisions = 0,
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
      totalReviewedCards: map["totalReviewedCards"],
      totalRightCardsReviewed: map["totalRightCardsReviewed"],
      streak: map["streak"],
      lastTimeUsedApp: map["lastTimeUsedApp"] != null
          ? DateTime.parse(map["lastTimeUsedApp"])
          : null,
      highestStreak: map["highestStreak"],
      dayCreated:
          map["dayCreated"] != null ? DateTime.parse(map["dayCreated"]) : null,
      createdCollections: map["createdCollections"],
      createdCards: map["createdCards"],
      totalGoldEarned: map["totalGoldEarned"],
      totalGoldSpent: map["totalGoldSpent"],
      totalPetXp: map["totalPetXp"],
      totalGoldFromRevisions: map["totalGoldFromRevisions"],
      totalXpFromRevisions: map["totalXpFromRevisions"],
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
      "totalReviewedCards": totalReviewedCards,
      "totalRightCardsReviewed": totalRightCardsReviewed,
      "streak": streak,
      "lastTimeUsedApp": lastTimeUsedApp?.toIso8601String(),
      "highestStreak": highestStreak,
      "dayCreated": dayCreated?.toIso8601String(),
      "createdCollections": createdCollections,
      "createdCards": createdCards,
      "totalGoldEarned": totalGoldEarned,
      "totalGoldSpent": totalGoldSpent,
      "totalPetXp": totalPetXp,
      "totalGoldFromRevisions": totalGoldFromRevisions,
      "totalXpFromRevisions": totalXpFromRevisions,
    };
  }
}
