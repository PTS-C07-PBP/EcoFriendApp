import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../custom_drawer.dart';
import '';

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
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.black, fontFamily: 'Lobster', fontSize: 23),
          ),
        ),
        drawer: const CustomDrawer(),
        body: FutureBuilder(
            future: fetchHistory(request),
            builder: (context, AsyncSnapshot snapshot) {
              if (request.loggedIn == false) {
                return const Center(
                    child: Text("Login to view leaderboard!",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Lobster',
                            fontSize: 40)));
              }
              else {
                if (!snapshot.hasData) {
                  return const Center(
                      child: Text("You don't have any history",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lobster',
                              fontSize: 40)));
                }
                else {return Scaffold(
                    appBar: AppBar(
                      title: Text(
                        widget.title,
                        style: const TextStyle(
                            color: Colors.black, fontFamily: 'Lobster', fontSize: 23),
                      ),
                    ),
                    drawer: const CustomDrawer(),
                    body: FutureBuilder(
                        future: fetchHistory(request),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (request.loggedIn == false) {
                            return const Center(
                                child: Text("Login and track your carbon footprint!",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Lobster',
                                        fontSize: 40)));
                          } else {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: Text("You don't have any history",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Lobster',
                                          fontSize: 40)));
                            } else {
                              return makeCards(request, snapshot);
                            }
                          }
                        }
                      // This trailing comma makes auto-formatting nicer for build methods.
                    ),
                    floatingActionButton: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Expanded(child: Container()),
                        if (request.loggedIn == true)
                          FloatingActionButton(
                            onPressed: addFootprint,
                            tooltip: 'Add Footprint',
                            child: const Icon(Icons.add),
                          ),
                        // This trailing comma makes auto-formatting nicer for build methods.
                      ]),
                    ));
                }
              }
            }
          // This trailing comma makes auto-formatting nicer for build methods.
        ),
        );
  }

  // fetch json data
  Future<List<Leaderboard>> fetchHistory(CookieRequest request) async {
    List<Leaderboard> footprintHistory = [];
    if (request.loggedIn == true) {
      var res = await request.get(
        'https://ecofriend.up.railway.app/leaderboard/show_json',
      );

      for (var d in res) {
        if (d != null) {
          footprintHistory.add(Leaderboard.fromJson(d));
        }
      }
    }
    return footprintHistory;
  }

  makeTable(CookieRequest request, AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (_, index) => Card(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            // align the text to the left instead of centered
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: Text(
                  "You traveled for ${snapshot.data![index].fields.mileage} km and create as much as ${snapshot.data![index].fields.carbon} g of carbon footprint",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${snapshot.data![index].fields.datetimeShow}",
                  style: const TextStyle(
                    fontSize: 14.0,
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





