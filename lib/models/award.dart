enum AwardCategory {
  cards,
  pets,
  social,
}

class Award {
  final AwardCategory category;
  final String iconPath;
  final String title;
  final String description;
  final int target;
  final int rewardValue;

  const Award(
    this.category,
    this.iconPath,
    this.title,
    this.description,
    this.target,
    this.rewardValue,
  );
}
