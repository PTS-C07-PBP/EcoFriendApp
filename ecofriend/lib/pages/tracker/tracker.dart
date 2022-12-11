import 'dart:convert';
import 'package:ecofriend/models/footprint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../custom_drawer.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({Key? key}) : super(key: key);

  @override
  _TrackerPageState createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  // fetch json data
  Future<List<Footprint>> fetchWatchList() async {
    // how
    var url = Uri.parse('https://ecofriend.up.railway.app/tracker/get_data');
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object MyWatchList
    List<Footprint> history = [];
    for (var d in data) {
      if (d != null) {
        history.add(Footprint.fromJson(d));
      }
    }
    return history;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Carbon Footprint Tracker'),
        ),
        drawer: const CustomDrawer(),
        body: FutureBuilder(
            future: fetchWatchList(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Column(
                    children: const [
                      Text(
                        "You don't have any history",
                        style: TextStyle(
                            color: Color(0xff59A5D8),
                            fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index)=> Card(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Column(
                          // align the text to the left instead of centered
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text("${snapshot.data![index].fields.datetimeShow}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
            }
        )
    );
  }
}