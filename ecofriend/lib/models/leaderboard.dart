// To parse this JSON data, do
//
//     final leaderboard = leaderboardFromJson(jsonString);

import 'dart:convert';

List<Leaderboard> leaderboardFromJson(String str) => List<Leaderboard>.from(
    json.decode(str).map((x) => Leaderboard.fromJson(x)));

String leaderboardToJson(List<Leaderboard> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Leaderboard {
  Leaderboard({
    required this.rank,
    required this.nama,
    required this.mileage,
    required this.footprint,
  });

  int rank;
  String nama;
  double mileage;
  double footprint;

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
        rank: json["rank"],
        nama: json["nama"],
        mileage: json["mileage"].toDouble(),
        footprint: json["footprint"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "rank": rank,
        "nama": nama,
        "mileage": mileage,
        "footprint": footprint,
      };
}
