import 'package:covid_app/parsers/parser.dart';
import 'dart:io';
import 'dart:convert';
import 'package:covid_app/universal_entry.dart';

class InstagramParser extends Parser {
  @override
  final String name = "Instagram";

  @override
  Future<List<UniversalEntry>> format(String path) async {
    return await _parseMessages(path) + await _parseLikes(path);
  }

  Future<List<UniversalEntry>> _parseMessages(String path) async {
    List<UniversalEntry> result = [];
    String filename = path + "/messages.json";
    String raw = await File(filename).readAsString();
    List<dynamic> jsonResultA = json.decode(raw);
    List<Map<String, dynamic>> jsonResult =
        jsonResultA.map((c) => c as Map<String, dynamic>).toList();
    for (Map<String, dynamic> chat in jsonResult) {
      for (Map<String, dynamic> message in chat["conversation"]) {
        var entry = UniversalEntry(
            "instagram",
            message["sender"],
            formatTime(message["created_at"]),
            (chat["participants"].length > 2)
                ? "instagram_group_message"
                : "instagram_direct_message");
        if (message.containsKey("text")) entry.content = message["text"];
        result.add(entry);
      }
    }
    return result;
  }

  Future<List<UniversalEntry>> _parseLikes(String path) async {
    List<UniversalEntry> result = [];
    String filename = path + "/likes.json";
    String raw = await File(filename).readAsString();
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
