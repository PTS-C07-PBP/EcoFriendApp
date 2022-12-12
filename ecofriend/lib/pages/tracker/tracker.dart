import 'package:ecofriend/models/footprint.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../custom_drawer.dart';
import 'add_footprint.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key});

  final String title = 'Carbon Footprint Tracker';

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  //int _thisUser = 1;
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

  // fetch json data
  Future<List<Footprint>> fetchHistory(CookieRequest request) async {
    List<Footprint> footprintHistory = [];
    if (request.loggedIn == true) {
      var res = await request.get(
        'https://ecofriend.up.railway.app/tracker/show_json',
      );

      // melakukan konversi data json menjadi object Footprint
      for (var d in res) {
        if (d != null) {
          footprintHistory.add(Footprint.fromJson(d));
        }
      }
    }
    return footprintHistory;
  }

  makeCards(CookieRequest request, AsyncSnapshot snapshot) {
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

  void addFootprint() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddFootprintPage()),
    );
  }
}
