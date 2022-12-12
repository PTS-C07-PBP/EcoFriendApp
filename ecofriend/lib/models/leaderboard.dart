// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  Welcome({
    required this.rank,
    required this.nama,
    required this.mileage,
    required this.footprint,
  });

  int rank;
  String nama;
  int mileage;
  int footprint;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    rank: json["rank"],
    nama: json["nama"],
    mileage: json["mileage"],
    footprint: json["footprint"],
  );

  Map<String, dynamic> toJson() => {
    "rank": rank,
    "nama": nama,
    "mileage": mileage,
    "footprint": footprint,
  };
}
