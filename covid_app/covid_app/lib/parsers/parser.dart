import 'package:covid_app/universal_entry.dart';

abstract class Parser {
  final String path;

  Parser(this.path);
  Future<List<UniversalEntry>> format();
}
