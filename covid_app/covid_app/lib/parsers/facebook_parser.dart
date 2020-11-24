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
    return await _parseMessages(path) + await _parseLikes(path);
  }

  Future<List<UniversalEntry>> _parseMessages(String path) async {}

  Future<List<UniversalEntry>> _parseLikes(String path) async {}
}
