/* import 'package:covid_app/parsers/location_parsers/location_parser.dart';
import 'dart:io';
import 'dart:convert';
import 'package:covid_app/location_entry.dart';
import 'package:flutter/services.dart';
import 'package:ipfinder/ipfinder.dart';

class InstagramLocationParser extends LocationParser {
  @override
  final String name = "Instagram location data";

  @override
  Future<List<LocationEntry>> format(String path) async {
    return await _parseActivity(path);
  }

  Future<List<LocationEntry>> _parseActivity(String path) async {
    List<LocationEntry> result = [];
    String filename = path + "/login_and_account_creation/login_activity.json";
    String raw = await File(filename).readAsString();
    Map<String, dynamic> jsonResult = json.decode(raw);

    for (Map<String, dynamic> instance in jsonResult["account_history_login_activity"]) {
      DateTime time = DateTime.fromMillisecondsSinceEpoch(1000*instance["Time"]["timestamp"]);
      DateTime twoWeeksAgo = DateTime.now().subtract(const Duration(days: 14));

      if (time.isAfter(twoWeeksAgo)) break;

      Ipfinder ipfinder = Ipfinder("2a849c1d98c0265b8e854a0e3408c72949a74392");
      IpResponse ip = await ipfinder.getAddressInfo(instance["IP Address"]["value"]);

      result.add(LocationEntry("instagram", ip.city, ip.regionName, ip.countryCode, time));
    }

    return result;
  }
} */