import 'dart:convert';

StatusCodeListItem statusCodeListItemFromJson(String str) =>
    StatusCodeListItem.fromMap(json.decode(str));

String statusCodeListItemToJson(StatusCodeListItem data) =>
    json.encode(data.toMap());

class StatusCodeListItem {
  final int id;
  final String code;
  final String description;

  StatusCodeListItem({
    this.id,
    this.code,
    this.description,
  });

  factory StatusCodeListItem.fromMap(Map<String, dynamic> json) =>
      StatusCodeListItem(
        id: json["id"],
        code: json["code"],
        description: json["short_description_rus"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "short_description_rus": description,
      };
}
