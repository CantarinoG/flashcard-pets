class Collection {
  final String id;
  final String name;
  final int subjectCode;
  final String description;

  const Collection(
    this.id,
    this.name,
    this.subjectCode,
    this.description,
  );

  static Collection fromMap(Map<String, dynamic> map) {
    return Collection(
      map["id"],
      map["name"],
      map["subjectCode"],
      map["description"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "subjectCode": subjectCode,
      "description": description,
    };
  }
}
