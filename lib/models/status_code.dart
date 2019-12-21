import 'dart:convert';

StatusCode statusCodeFromJson(String str) =>
    StatusCode.fromMap(json.decode(str));

String statusCodeToJson(StatusCode data) => json.encode(data.toMap());

class StatusCode {
  final int id;
  final String code;
  final String shortDescription;
  final String description;

  StatusCode({
    this.id,
    this.code,
    this.shortDescription,
    this.description,
  });

  factory StatusCode.fromMap(Map<String, dynamic> json) => StatusCode(
        id: json["id"],
        code: json["code"],
        shortDescription: json["short_description"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "short_description": shortDescription,
        "description": description,
      };
}
