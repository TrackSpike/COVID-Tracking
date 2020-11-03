import 'package:covid_app/parsers/parser.dart';
import 'dart:convert';
import 'package:covid_app/universal_entry.dart';
import 'package:flutter/services.dart';

class SnapchatParser extends Parser {
  SnapchatParser(String path) : super(path);

  @override
  Future<List<UniversalEntry>> format() async {
    return await _parseSnaps();
  }

  Future<List<UniversalEntry>> _parseSnaps() async {
    List<UniversalEntry> result = [];
    String filename = path + "/json/snap_history.json";
    String raw = await rootBundle.loadString(filename);
    Map<String, dynamic> jsonResult = json.decode(raw);
    for (Map<String, dynamic> snap in jsonResult["Received Snap History"]) {
      result.add(UniversalEntry(
          "snapchat",
          snap["From"],
          formatTime(snap["Created"]),
          (snap["Media Type"] == "IMAGE")
              ? "snapchat_got_image"
              : (snap["Media Type"] == "VIDEO")
                  ? "snapchat_got_video"
                  : "snapchat_got_other"));
    }
    for (Map<String, dynamic> snap in jsonResult["Sent Snap History"]) {
      result.add(UniversalEntry(
          "snapchat",
          snap["To"],
          formatTime(snap["Created"]),
          (snap["Media Type"] == "IMAGE")
              ? "snapchat_sent_image"
              : (snap["Media Type"] == "VIDEO")
                  ? "snapchat_sent_video"
                  : "snapchat_sent_other"));
    }
    return result;
  }

  DateTime formatTime(String time) {
    return DateTime.parse(time);
  }
}
