import 'package:charts_flutter/flutter.dart' as charts;

class CaloriesChart {
  final String date;
  final double calories;
  final charts.Color barColor;

  CaloriesChart(
      {required this.date, required this.calories, required this.barColor});
}
