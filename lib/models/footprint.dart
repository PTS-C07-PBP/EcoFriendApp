// To parse this JSON data, do
//
//     final Footprint = FootprintFromJson(jsonString);

import 'dart:convert';

List<dynamic> footprintFromJson(String str) =>
    List<dynamic>.from(json.decode(str).map((x) => x));

String footprintToJson(List<dynamic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));

//List<Footprint> footprintFromJson(String str) =>
//  List<Footprint>.from(json.decode(str).map((x) => Footprint.fromJson(x)));

//String footprintToJson(List<Footprint> data) =>
//  json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Footprint {
  Footprint({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Footprint.fromJson(Map<String, dynamic> json) => Footprint(
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
    required this.datetime,
    required this.mileage,
    required this.carbon,
    required this.onFoot,
    required this.datetimeShow,
    required this.toOrder,
  });

  dynamic user;
  DateTime datetime;
  double mileage;
  double carbon;
  bool onFoot;
  String datetimeShow;
  double toOrder;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        datetime: DateTime.parse(json["datetime"]),
        mileage: json["mileage"],
        carbon: json["carbon"],
        onFoot: json["onFoot"],
        datetimeShow: json["datetime_show"],
        toOrder: json["to_order"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "datetime": datetime.toIso8601String(),
        "mileage": mileage,
        "carbon": carbon,
        "onFoot": onFoot,
        "datetime_show": datetimeShow,
        "to_order": toOrder,
      };
}
