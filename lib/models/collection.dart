class Collection {
  final String id;
  String name;
  int subjectCode;
  String description;

  Collection(
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
