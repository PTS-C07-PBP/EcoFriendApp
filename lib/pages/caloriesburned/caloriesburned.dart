import 'package:ecofriend/models/caloriesburned/calories.dart';
import 'package:ecofriend/models/caloriesburned/person.dart';
import 'package:ecofriend/models/caloriesburned/motive.dart';
import 'package:ecofriend/pages/caloriesburned/add_weight.dart';
import 'package:ecofriend/models/caloriesburned/calories_chart.dart';
import 'package:ecofriend/pages/caloriesburned/calories_bar_chart.dart';

import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../custom_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) {
          CookieRequest request = CookieRequest();
          return request;
        },
        child: MaterialApp(
          title: 'Calories Burned',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xff00fc97),
                primary: const Color(0xff00fc97)),
          ),
          home: const CaloriesBurnedPage(),
        ));
  }
}

class CaloriesBurnedPage extends StatefulWidget {
  const CaloriesBurnedPage({Key? key}) : super(key: key);

  @override
  _CaloriesBurnedPageState createState() => _CaloriesBurnedPageState();
}

class _CaloriesBurnedPageState extends State<CaloriesBurnedPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final f = new DateFormat('yyyy-MM-dd hh:mm');
  final _textshowup = TextEditingController();
  String showText = "";
  String addText = "";
  List<CaloriesChart> datachart = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final request = context.watch<CookieRequest>();
    Future<List<Calories>> fetchCalories() async {
      var response = await request.get(
          'https://ecofriend.up.railway.app/caloriesburned/calories_chart/');

      // melakukan decode response menjadi bentuk json

      // melakukan konversi data json menjadi object ToDo

      List<Calories> listCaloriesData = [];
      listCaloriesData.add(Calories.fromJson(response));
      
      return listCaloriesData;
    }

    Future<List<Person>> fetchPerson() async {
      var response = await request.get(
          'https://ecofriend.up.railway.app/caloriesburned/show_json_person_detail/');
      // melakukan decode response menjadi bentuk json

      // melakukan konversi data json menjadi object ToDo
      List<Person> listPersonData = [];
      for (var d in response) {
        if (d != null) {
          listPersonData.add(Person.fromJson(d));
        }
      }
      return listPersonData;
    }

    Future<List<Motive>> fetchMotive() async {
      var response = await request
          .get('https://ecofriend.up.railway.app/caloriesburned/show_json/');

      // melakukan decode response menjadi bentuk json

      // melakukan konversi data json menjadi object ToDo
      List<Motive> listMotiveData = [];
      for (var d in response) {
        if (d != null) {
          listMotiveData.add(Motive.fromJson(d));
        }
      }
      return listMotiveData;
    }

    void addingBar() async {
      var response = await request.get(
          'https://ecofriend.up.railway.app/caloriesburned/calories_chart/');
      for (int i = 0; i < response["date"].length; i++) {
        datachart.add(CaloriesChart(
            date: response["date"][i],
            calories: response["calories"][i],
            barColor: charts.ColorUtil.fromDartColor(const Color(0xff00fc97))));
      }
    }

    if (request.loggedIn) {
      addingBar();
      return Scaffold(
        appBar: AppBar(
          title: Text('Calories Burned'),
        ),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: fetchPerson(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.data!.length == 0) {
                        // print("testing");
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddWeightPage()));
                        });
                      }
                      return FutureBuilder(
                          future: fetchCalories(),
                          builder: (context, AsyncSnapshot snapshot) {

                            if (snapshot.data == null) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Text(
                                        'You haven not burned any calories yet :(',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Lobster',
                                            fontSize: 23),
                                      )
                                    ],
                                  ),
                                );
                              }
                              return Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        'Welcome To Your Burned Calories Tracker',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  FutureBuilder(
                                      future: fetchMotive(),
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        if (snapshot.data == null) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else {
                                          if (!snapshot.hasData) {
                                            return const Padding(
                                              padding: EdgeInsets.all(20),
                                              child: Center(
                                                child: Text(
                                                    'Belum ada motivasi nih :('),
                                              ),
                                            );
                                          }
                                          return Column(
                                            children: [
                                              Container(
                                                child: Text(
                                                  showText,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),                                              
                                              TextButton(
                                                  onPressed: () {
                                                    Random random =
                                                        new Random();
                                                    int baru = random.nextInt(
                                                        snapshot.data!.length);
                                                    setState(() {
                                                      showText = snapshot
                                                          .data![baru]
                                                          .fields
                                                          .sentences;
                                                    });
                                                  },
                                                  child: const Text(
                                                      "Show Motivation"))
                                            ],
                                          );
                                        }
                                      }),

                                  Center(
                                    child: CaloriesChartMake(data: datachart),
                                  ),


                                  Center(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.all(0),
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(300.0),
                                            border: TableBorder.all(
                                                color: Color.fromARGB(
                                                    255, 69, 70, 70),
                                                style: BorderStyle.solid,
                                                width: 2),
                                            children: [
                                              TableRow(children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                        color: Colors.green,
                                                        width: 300.0,
                                                        child: Center(
                                                          child: Text(
                                                            'Date',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      color: Colors.green,
                                                      width: 300.0,
                                                      child: Center(
                                                        child: Text(
                                                          'Calories',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ]),
                                              for (int i = 0;
                                                  i <
                                                      snapshot
                                                          .data![0].date.length;
                                                  i++)
                                                TableRow(children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        '${snapshot.data![0].date[i]}',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        '${snapshot.data![0].calories[i]}',
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                            ],
                                          ),
                                        ),

                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                  'Add Your New Motivation Below'),
                                            ),
                                            Container(
                                              child: Text(addText),
                                            ),
                                            SizedBox(
                                              width: 500,
                                              child: TextField(
                                                controller: _textshowup,
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: "Type here"),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                // print(_textshowup.text);

                                                final response = await request.post(
                                                    "https://ecofriend.up.railway.app/caloriesburned/add_motive/",
                                                    {
                                                      'motive':
                                                          _textshowup.text,
                                                    });

                                                final snackbar = SnackBar(
                                                  content: const Text(
                                                      "Yay! Your motivation has beed added"),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackbar);

                                                _textshowup.clear();
                                              },
                                              child: Text('Submit'),
                                            ),
                                          ],
                                        )                                        
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                          });
                    }
                  })
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text('Calories Burned'),
          ),
          drawer: const CustomDrawer(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login to track your burned calories',
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'Lobster', fontSize: 23),
                )
              ],
            ),
          ));
    }
  }
}
