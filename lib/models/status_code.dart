import 'dart:convert';

StatusCode statusCodeFromJson(String str) =>
    StatusCode.fromMap(json.decode(str));

String statusCodeToJson(StatusCode data) => json.encode(data.toMap());

class StatusCode {
  final int id;
  final String code;
  final String shortDescriptionRus;
  final String shortDescriptionEng;
  final String descriptionRus;
  final String descriptionEng;

  StatusCode({
    this.id,
    this.code,
    this.shortDescriptionRus,
    this.shortDescriptionEng,
    this.descriptionRus,
    this.descriptionEng,
  });

  factory StatusCode.fromMap(Map<String, dynamic> json) => StatusCode(
        id: json["id"],
        code: json["code"],
        shortDescriptionRus: json["short_description_rus"],
        shortDescriptionEng: json["short_description_eng"],
        descriptionRus: json["description_rus"],
        descriptionEng: json["description_eng"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "short_description_rus": shortDescriptionRus,
        "short_description_eng": shortDescriptionEng,
        "description_rus": descriptionRus,
        "description_eng": descriptionEng,
      };
}
