import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

final timeWeight = 0.01;

Future<Map<String, double>> calculate(List<Map<String, dynamic>> dict) async {

  String weightString = await rootBundle.loadString('assets/algo_weights.json');

  Map<String, dynamic> weights = json.decode(weightString);

  Map<String, double> results = {};

  dict.forEach((entry) {
    DateTime time = DateTime.parse(entry['time']);
    int dif = DateTime.now().difference(time).inDays; //todo int to double
    double weight = weights[entry['type']];
    double value =
        (weight - timeWeight * dif * weight).clamp(0, double.infinity);
    results[entry['person']] = (results['person'] ?? 0) + value;
  });

  return results;
}
