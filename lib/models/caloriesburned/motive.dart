// To parse this JSON data, do
//
//     final motive = motiveFromJson(jsonString);

import 'dart:convert';

List<Motive> motiveFromJson(String str) =>
    List<Motive>.from(json.decode(str).map((x) => Motive.fromJson(x)));

String motiveToJson(List<Motive> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Motive {
  Motive({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Motive.fromJson(Map<String, dynamic> json) => Motive(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields({
    required this.user,
    required this.sentences,
  });

  int user;
  String sentences;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        sentences: json["sentences"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "sentences": sentences,
      };
}
