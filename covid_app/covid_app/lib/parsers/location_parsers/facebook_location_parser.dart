import 'package:covid_app/parsers/location_parsers/location_parser.dart';
import 'dart:io';
import 'dart:convert';
import 'package:covid_app/location_entry.dart';
import 'package:flutter/services.dart';

class FacebookLocationParser extends LocationParser {
  @override
  final String name = "Facebook location data";

  @override
  Future<List<LocationEntry>> format(String path) async {
    return await _parseActivity(path);
  }

  Future<List<LocationEntry>> _parseActivity(String path) async {
    List<LocationEntry> result = [];
    String filename = path + "/security_and_login_information/account_activity.json";
    String raw = await File(filename).readAsString();
    Map<String, dynamic> jsonResult = json.decode(raw);

    for (Map<String, dynamic> instance in jsonResult["account_activity"]) {
      DateTime time = DateTime.fromMillisecondsSinceEpoch(1000*instance["timestamp"]);
      DateTime twoWeeksAgo = DateTime.now().subtract(const Duration(days: 14));

      if (time.isAfter(twoWeeksAgo)) break;

      result.add(LocationEntry("facebook", instance["city"], instance["region"], instance["country"], time));
    }

    return result;
  }
}