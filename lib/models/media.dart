class Media {
  final String id;
  String fileString;

  Media(
    this.id,
    this.fileString,
  );

  static Media fromMap(Map<String, dynamic> map) {
    return Media(
      map["id"],
      map["fileString"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "fileString": fileString,
    };
  }
}
