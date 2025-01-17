import 'dart:convert';

class Flashcard {
  final String id;
  String collectionId;
  String frontContent;
  String backContent;
  int repeticoes;
  double easeFactor;
  double interval;
  DateTime revisionDate;
  List<String> audioFiles;
  List<String> imgFiles;

  Flashcard(
    this.id,
    this.collectionId,
    this.frontContent,
    this.backContent,
    this.revisionDate,
    this.audioFiles,
    this.imgFiles, {
    this.repeticoes = 0,
    this.easeFactor = 2.5,
    this.interval = 0,
  });

  static Flashcard fromMap(Map<String, dynamic> map) {
    return Flashcard(
      map["id"],
      map["collectionId"],
      map["frontContent"],
      map["backContent"],
      DateTime.parse(map["revisionDate"]),
      List<String>.from(json.decode(map["audioFiles"])),
      List<String>.from(json.decode(map["imgFiles"])),
      repeticoes: map["repeticoes"] ?? 0,
      easeFactor: (map["easeFactor"] as num).toDouble(),
      interval: (map["interval"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "collectionId": collectionId,
      "frontContent": frontContent,
      "backContent": backContent,
      "repeticoes": repeticoes,
      "easeFactor": easeFactor,
      "interval": interval,
      "revisionDate": revisionDate.toIso8601String(),
      "audioFiles": json.encode(audioFiles),
      "imgFiles": json.encode(imgFiles),
    };
  }
}
