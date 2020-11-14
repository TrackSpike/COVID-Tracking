import 'package:covid_app/universal_entry.dart';

abstract class Parser {
  final String name = "Parser";
  Future<List<UniversalEntry>> format(String path);
}
