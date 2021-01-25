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
    for (Map<String, dynamic> like in jsonResult["reactions"]) {
      int timestamp = like["timestamp"];
      String formatted_likee = formatLikee(like["title"]);
      if(formatted_likee!="ERROR") {
        result.add(UniversalEntry("facebook", formatted_likee, DateTime.fromMillisecondsSinceEpoch(timestamp*1000), "facebook_like"));
      }
    }
    return result;
  }

  String formatLikee(String title) {
    String formatted_string = "";
    try {
      if(title.indexOf("likes")>-1) {
        formatted_string = title.substring(title.indexOf("likes")+6,title.indexOf("'s"));
      } else {
        formatted_string = title.substring(title.indexOf("liked")+6, title.indexOf("'s"));
      }
    } catch(RangeError) {
      return "ERROR";
    }
    return formatted_string;
  }
}
