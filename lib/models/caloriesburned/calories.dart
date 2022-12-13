// To parse this JSON data, do
//
//     final calories = caloriesFromJson(jsonString);

import 'dart:convert';

Calories caloriesFromJson(String str) => Calories.fromJson(json.decode(str));

String caloriesToJson(Calories data) => json.encode(data.toJson());

class Calories {
  Calories({
    required this.date,
    required this.calories,
  });

  List<DateTime> date;
  List<double> calories;

  factory Calories.fromJson(Map<String, dynamic> json) => Calories(
        date: List<DateTime>.from(json["date"].map((x) => DateTime.parse(x))),
        calories: List<double>.from(json["calories"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "date": List<dynamic>.from(date.map((x) => x.toIso8601String())),
        "calories": List<dynamic>.from(calories.map((x) => x)),
      };
}
