import 'package:ecofriend/models/footprint.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Footprint>> fetchFootprint() async {
  var url =
      Uri.parse('https://ecofriend.up.railway.app/tracker/show_json');
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
  List<Footprint> listFootprintData = [];
  for (var d in data) {
    if (d != null) {
      listFootprintData.add(Footprint.fromJson(d));
    }
  }

  return listFootprintData;
}
