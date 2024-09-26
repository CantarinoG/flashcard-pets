class User {
  int gold;
  int xp;

  User({
    this.gold = 100,
    this.xp = 0,
  });

  static User fromMap(Map<String, dynamic> map) {
    return User(
      gold: map["gold"],
      xp: map["xp"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "gold": gold,
      "xp": xp,
    };
  }
}
