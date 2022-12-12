import 'package:ecofriend/models/caloriesburned/calories_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:ecofriend/pages/caloriesburned/caloriesburned.dart';

class CaloriesChartMake extends StatelessWidget {
  final List<CaloriesChart> data;

  CaloriesChartMake({required this.data});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<charts.Series<CaloriesChart, String>> series = [
      charts.Series(
          id: "Calories",
          data: data,
          domainFn: (CaloriesChart series, _) => series.date,
          measureFn: (CaloriesChart series, _) => series.calories,
          colorFn: (CaloriesChart series, _) => series.barColor)
    ];
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Text(
                "Calories Burned",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                  child: charts.BarChart(
                series,
                animate: true,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
