// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';

List<dynamic> articleFromJson(String str) => List<dynamic>.from(json.decode(str).map((x) => x));

String articleToJson(List<dynamic> data) => json.encode(List<dynamic>.from(data.map((x) => x)));

class Article {
    Article({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory Article.fromJson(Map<String, dynamic> json) => Article(
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
        required this.adminCreated,
        required this.image,
        required this.link,
        required this.title,
        required this.date,
        required this.region,
        required this.description,
    });

    dynamic user;
    bool adminCreated;
    String image;
    String link;
    String title;
    DateTime date;
    String region;
    String description;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        adminCreated: json["admin_created"],
        image: json["image"],
        link: json["link"],
        title: json["title"],
        date: DateTime.parse(json["date"]),
        region: json["region"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "admin_created": adminCreated,
        "image": image,
        "link": link,
        "title": title,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "region": region,
        "description": description,
    };
}
