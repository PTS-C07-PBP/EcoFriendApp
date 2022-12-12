// To parse this JSON data, do
//
//     final person = personFromJson(jsonString);

import 'dart:convert';

List<Person> personFromJson(String str) =>
    List<Person>.from(json.decode(str).map((x) => Person.fromJson(x)));

String personToJson(List<Person> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Person {
  Person({
    required this.name,
    required this.weight,
  });

  String name;
  double weight;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        name: json["name"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "weight": weight,
      };
}
