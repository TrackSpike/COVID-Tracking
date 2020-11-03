import 'package:covid_app/parsers/parser.dart';
import 'dart:convert';
import 'package:covid_app/universal_entry.dart';
import 'package:flutter/services.dart';

class InstagramParser extends Parser {
  InstagramParser(String path) : super(path);

  @override
  Future<List<UniversalEntry>> format() async {
    return await _parseMessages() + await _parseLikes();
  }

  Future<List<UniversalEntry>> _parseMessages() async {
    List<UniversalEntry> result = [];
    String filename = path + "messages.json";
    String raw = await rootBundle.loadString(filename);
    List<Map<String, dynamic>> jsonResult = json.decode(raw);
    for (Map<String, dynamic> chat in jsonResult) {
      for (Map<String, dynamic> message in chat["conversation"]) {
        result.add(UniversalEntry(
            "instagram",
            message["sender"],
            formatTime(message["created_at"]),
            (chat["participants"].length > 2)
                ? "instagram_group_message"
                : "instagram_direct_message"));
      }
    }
    return result;
  }

  Future<List<UniversalEntry>> _parseLikes() async {
    List<UniversalEntry> result = [];
    String filename = path + "likes.json";
    String raw = await rootBundle.loadString(filename);
    Map<String, dynamic> jsonResult = json.decode(raw);
    for (List<dynamic> like in jsonResult["media_likes"]) {
      result.add(UniversalEntry(
          "instagram", like[1], formatTime(like[0]), "instagram_like"));
    }
    return result;
  }

  DateTime formatTime(String time) {
    return DateTime.parse(time);
  }
}
