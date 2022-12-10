import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../custom_drawer.dart';

import '../../models/review.dart';

import 'add_review.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});
  final String title = 'Review';

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
              color: Colors.black, fontFamily: 'Lobster', fontSize: 23),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: const CustomDrawer(),
      body: FutureBuilder(
          future: getReview(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return Column(
                  children: const [
                    Text(
                      "Tidak ada review.",
                      style: TextStyle(color: Color(0x00000000), fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                // Make cards
                return makeCards(snapshot);
              }
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: addReview,
        tooltip: 'Add Review',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<Review>> getReview() async {
    var url = Uri.parse('https://ecofriend.up.railway.app/review/json');

    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    // melakukan decode response menjadi bentuk json
    var data = json.decode(response.body);

    // membuat list untuk menampung data
    List<Review> reviews = [];

    // melakukan looping untuk mengambil data
    for (var u in data) {
      if (u != null) {
        reviews.add(Review.fromJson(u));
      }
    }

    reviews.sort((a,b) => b.date.compareTo(a.date));

    return reviews;
  }

  addReview() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddReviewPage()),
    );
  }

  makeCards(AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  snapshot.data[index].title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(snapshot.data[index].description),
                trailing: Text(snapshot.data[index].getRating()),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(snapshot.data[index].username),
                  const SizedBox(width: 8),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(snapshot.data[index].date.toString().substring(0, 10)),
                  const SizedBox(width: 8),
                ],
              ),
              // date
            ],
          ),
        );
      },
    );
  }
}
