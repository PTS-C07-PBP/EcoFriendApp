import 'package:ecofriend/models/caloriesburned/person.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Person>> fetchFootprint() async {
  var url =
      Uri.parse('https://ecofriend.up.railway.app/caloriesburned/show_json_person/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object ToDo
  List<Person> listPersonData = [];
  for (var d in data) {
    if (d != null) {
      listPersonData.add(Person.fromJson(d));
    }
  }

  return listPersonData;
}
