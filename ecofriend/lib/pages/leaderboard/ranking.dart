import 'dart:convert';

import 'package:ecofriend/models/leaderboard.dart';
import 'package:ecofriend/pages/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  final String title = 'Leaderboard';

  @override
  State<LeaderboardPage> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: const Color(0xffcfffcc),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
              color: Colors.black, fontFamily: 'Lobster', fontSize: 23),
        ),
      ),
      drawer: const CustomDrawer(),
      body: FutureBuilder(
          future: fetchLeaderboard(request),
          builder: (context, AsyncSnapshot snapshot) {
            if (request.loggedIn == false) {
              return const Center(
                  child: Text("Login to view leaderboard!",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lobster',
                          fontSize: 40)));
            } else {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return const Center(
                    child: Text("You don't have any history",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Lobster',
                            fontSize: 40)));
              } else {
                return Container(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text("Rank")),
                          DataColumn(label: Text("Nama")),
                          DataColumn(label: Text("Mileage")),
                          DataColumn(label: Text("Footprint")),
                        ],
                        rows: [...makeTable(snapshot.data!)],
                      ),
                    ));
              }
            }
          } // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  // fetch json data
  Future<List<Leaderboard>> fetchLeaderboard(CookieRequest request) async {
    List<Leaderboard> leaderboard = [];
    if (request.loggedIn == true) {
      var url = Uri.parse('https://ecofriend.up.railway.app/ranking/show_json');
      var response = await http.get(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json",
        },
      );
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      for (var d in data) {
        if (d != null) {
          leaderboard.add(Leaderboard.fromJson(d));
        }
      }
    }
    return leaderboard;
  }

  List<DataRow> makeTable(List<Leaderboard> leaderboard) {
    return leaderboard
        .map((Leaderboard entry) =>
        DataRow(cells: [
          DataCell(Text(entry.rank.toString())),
          DataCell(Text(entry.nama)),
          DataCell(Text(entry.mileage.toString())),
          DataCell(Text(entry.footprint.toString()))
        ]))
        .toList();
  }
}
