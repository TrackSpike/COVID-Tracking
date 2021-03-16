/// Scatter plot chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid_app/algo_result.dart';
import 'package:covid_app/pages/pyramid_page.dart';
import 'package:covid_app/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ResultChart extends StatelessWidget {
  final List<AlgoResult> results;

  const ResultChart(this.results);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      padding: EdgeInsets.all(10),
      child: charts.ScatterPlotChart(
        buildSeries(),
        behaviors: [],
      ),
    );
  }

  List<charts.Series<dynamic, num>> buildSeries() {
    List<AlgoResult> nResults = results.map((AlgoResult result) {
      if (sharedPrefs.useLogScale) result.score = log(result.score);
      return result;
    }).toList();
    return [
      charts.Series<AlgoResult, int>(
        id: 'Results',
        domainFn: (AlgoResult result, int rank) => rank,
        measureFn: (AlgoResult result, int rank) => result.score,
        colorFn: (AlgoResult result, int rank) =>
            charts.ColorUtil.fromDartColor(layerColors[result.level]),
        data: nResults,
      )
    ];
  }
}
