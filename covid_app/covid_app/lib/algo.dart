import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io';
import 'package:covid_app/algo_result.dart';
import 'package:covid_app/k_means.dart';
import 'package:covid_app/shared_prefs.dart';
import 'package:covid_app/universal_entry.dart';
import 'package:path_provider/path_provider.dart';
import 'weights_handler.dart';
import 'package:covid_app/emotion_classifier/classifier.dart';

final timeWeight = 0.01;
final emotionWeight = 3;

Future<List<AlgoResult>> calculate(List<UniversalEntry> data,
    [DateTime customDate, String saveExternal]) async {
  if (customDate == null)
    customDate = getLatestInteraction(data);
  else
    data = data.where((entry) => entry.time.isBefore(customDate)).toList();
  Classifier classifier;
  if (sharedPrefs.useEmotionNn) {
    classifier = Classifier();
    await classifier.initializationDone;
  }
  Map<String, double> weights = await getWeights();
  Map<String, double> results = {};
  data.forEach((entry) {
    DateTime time = entry.time;
    double dif =
        customDate.difference(time).inDays.toDouble(); //todo int to double
    double weight = weights[entry.type];
    double value =
        (weight - timeWeight * dif * weight).clamp(0.0, double.infinity);
    //Emotion
    if (sharedPrefs.useEmotionNn) {
      double emotionScore = entry.content != null && entry.content.isNotEmpty
          ? classifier.classify(entry.content)
          : 0;
      emotionScore *= emotionWeight;
      value = (value + emotionScore).clamp(0.0, double.infinity);
    }
    results[entry.person] = (results[entry.person] ?? 0) + value;
  });
  results.removeWhere((key, value) => value == 0);
  results.removeWhere((key, value) => key == sharedPrefs.excludedName);
  List<AlgoResult> resultTyped = [];
  results.forEach((key, value) => resultTyped.add(AlgoResult(key, value, 0)));
  resultTyped.sort((a, b) => b.score.compareTo(a.score));
  _calculateLevels(resultTyped);
  if (saveExternal == null || saveExternal.isEmpty)
    _writeFile(resultTyped);
  else
    _writeFile(resultTyped, saveExternal);
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
  List<double> values =
      List<double>.generate(results.length, (i) => results[i].score);
  List<int> clusters = kMeansCluster(4, values);
  for (int i = 0; i < clusters.length; i++) {
    results[i].level = clusters[i];
  }
}

void _writeFile(List<AlgoResult> results,
    [String fileName = "lastCalculatedAlgo"]) async {
  List<Map<String, dynamic>> jsonF = results.map((r) => r.toMap()).toList();
  Directory directory = await getApplicationDocumentsDirectory();
  File fileNew = await File("${directory.path}/$fileName.json").create();
  await fileNew.writeAsString(jsonEncode(jsonF));
}

DateTime getLatestInteraction(List<UniversalEntry> results) {
  DateTime latest = DateTime.fromMicrosecondsSinceEpoch(0);
  for (UniversalEntry entry in results) {
    if (entry.time.isAfter(latest)) latest = entry.time;
  }
  return latest;
}
