import 'dart:async' show Future;
import 'dart:convert';
import 'package:covid_app/universal_entry.dart';
import 'package:flutter/services.dart' show rootBundle;

final timeWeight = 0.01;

Future<Map<String, double>> calculate(List<UniversalEntry> data) async {
  String weightString = await rootBundle.loadString('assets/algo_weights.json');
  Map<String, double> weights =
      (json.decode(weightString) as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value.toDouble()));
  Map<String, double> results = {};
  data.forEach((entry) {
    DateTime time = entry.time;
    double dif =
        DateTime.now().difference(time).inDays.toDouble(); //todo int to double
    double weight = weights[entry.type];
    double value =
        (weight - timeWeight * dif * weight).clamp(0.0, double.infinity);
    results[entry.person] = (results[entry.person] ?? 0) + value;
  });
  return results;
}
