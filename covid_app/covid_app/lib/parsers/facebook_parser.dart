import 'package:covid_app/parsers/parser.dart';
import 'dart:io';
import 'dart:convert';
import 'package:covid_app/universal_entry.dart';
import 'package:flutter/services.dart';

class FacebookParser extends Parser {
  @override
  final String name = "Facebook";

  @override
  Future<List<UniversalEntry>> format(String path) async {
    return await _parseLikes(path);
  }

  Future<List<UniversalEntry>> _parseMessages(String path) async {}

  Future<List<UniversalEntry>> _parseLikes(String path) async {
    List<UniversalEntry> result = [];
    String filename = path + "/likes_and_reactions/posts_and_comments.json";
    String raw = await File(filename).readAsString();
    Map<String, dynamic> jsonResult = json.decode(raw);
    print(jsonResult["reactions"][0]);
    for (Map<String, dynamic> like in jsonResult["reactions"]) {
      String timestamp = like["timestamp"];
      result.add(UniversalEntry("facebook", like["title"], formatTime(timestamp), "facebook_like"));
    }
    print(result);
  }

  DateTime formatTime(String time) {
    return DateTime.parse(time);
  }
}
