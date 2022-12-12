
class Review {
  Review({
    required this.user,
    required this.username,
    required this.title,
    required this.description,
    required this.rating,
    required this.date,
  });

  dynamic user;
  String username;
  String title;
  String description;
  int rating;
  DateTime date;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        user: json["user"],
        username: json["user__username"],
        title: json["title"],
        description: json["description"],
        rating: json["rating"] as int,
        date: DateTime.parse(json["date"]),
      );
  Map<String, dynamic> toJson() => {
        "user": user,
        "user__username": username,
        "title": title,
        "description": description,
        "rating": rating,
        "date": date.toIso8601String(),
      };

  String getRating() {
    return '$rating of 5';
  }
}
