import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io';
import 'package:covid_app/algo_result.dart';
import 'package:covid_app/universal_entry.dart';
import 'package:path_provider/path_provider.dart';
import 'weights_handler.dart';

final timeWeight = 0.01;

Future<List<AlgoResult>> calculate(List<UniversalEntry> data) async {
  Map<String, double> weights = await getWeights();
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
  results.removeWhere((key, value) => value == 0);
  List<AlgoResult> resultTyped = [];
  results.forEach((key, value) => resultTyped.add(AlgoResult(key, value, 0)));
  resultTyped.sort((a, b) => b.score.compareTo(a.score));
  _calculateLevels(resultTyped);
  _writeFile(resultTyped);
  return resultTyped;
}

Future<bool> hasCachedResult() async {
  Directory directory = await getApplicationDocumentsDirectory();
  return File("${directory.path}/lastCalculatedAlgo.json").exists();
}

Future<List<AlgoResult>> getLastResult() async {
  if (await hasCachedResult()) {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File("${directory.path}/lastCalculatedAlgo.json");
    String text = await file.readAsString();
    List<AlgoResult> results = (json.decode(text) as List<dynamic>)
        .map((e) => AlgoResult.fromJson(e))
        .toList();
    return results;
  }
  return null;
}

void _calculateLevels(List<AlgoResult> results) {
  //This is not the best way to do it, it is just a placeholder.
  for (int i = 0; i < results.length; i++) {
    if (i / results.length < 0.05)
      results[i].level = 0;
    else if (i / results.length < 0.15)
      results[i].level = 1;
    else if (i / results.length < 0.35)
      results[i].level = 2;
    else
      results[i].level = 3;
  }
}

void _writeFile(List<AlgoResult> results) async {
  List<Map<String, dynamic>> jsonF = results.map((r) => r.toMap()).toList();
  Directory directory = await getApplicationDocumentsDirectory();
  File fileNew = File("${directory.path}/lastCalculatedAlgo.json");
  await fileNew.writeAsString(jsonEncode(jsonF));
}
