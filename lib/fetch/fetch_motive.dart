
import 'package:ecofriend/models/caloriesburned/motive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Motive>> fetchFootprint() async {
  var url =
      Uri.parse('https://ecofriend.up.railway.app/caloriesburned/show_json/');
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
  List<Motive> listMotiveData = [];
  for (var d in data) {
    if (d != null) {
      listMotiveData.add(Motive.fromJson(d));
    }
  }

  return listMotiveData;
}
