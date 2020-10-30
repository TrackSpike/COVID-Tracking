import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<Map<String, double>> _getDefaultWeights() async {
  String weightString = await rootBundle.loadString('assets/algo_weights.json');
  return (json.decode(weightString) as Map<String, dynamic>)
      .map((key, value) => MapEntry(key, value.toDouble()));
}

Future<Map<String, double>> getWeights() async {
  try {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/custom_weights.json');
    String weightString = await file.readAsString();
    return (json.decode(weightString) as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, value.toDouble()));
  } catch (E) {
    String weightString =
        await rootBundle.loadString('assets/algo_weights.json');
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/custom_weights.json');
    file.writeAsString(weightString);
    return (json.decode(weightString) as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, value.toDouble()));
  }
}

void writeWeights(Map<String, double> data) async {
  Directory directory = await getApplicationDocumentsDirectory();
  File file = File('${directory.path}/custom_weights.json');
  await file.writeAsString(json.encode(data));
}

void resetWeights() async {
  Map<String, double> defaultValue = await _getDefaultWeights();
  writeWeights(defaultValue);
}
