import 'dart:convert';
import 'dart:io';

import 'package:covid_app/algo.dart';
import 'package:covid_app/universal_entry.dart';
import 'package:path_provider/path_provider.dart';

void dateGenerator() async {
  DateTime startDate = DateTime.now().subtract(Duration(days: 7 * 200));
  for (int i = 0; i < 200; i++) {
    try {
      await testRun(startDate.add(Duration(days: i * 7)));

      print("Done loop $i");
    } on Exception {
      print("fail $i");
    }
  }
}

Future<void> testRun(DateTime customDateTime) async {
  Directory directory = await getApplicationDocumentsDirectory();
  File file = File('${directory.path}/lastUploadedData.json');
  String text = await file.readAsString();
  List<UniversalEntry> entries = (json.decode(text) as List<dynamic>)
      .map((e) => UniversalEntry.fromJson(e))
      .toList();
  await calculate(entries, customDateTime, customDateTime.toIso8601String());
}
