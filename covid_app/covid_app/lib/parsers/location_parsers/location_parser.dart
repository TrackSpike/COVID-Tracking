import 'package:covid_app/location_entry.dart';

abstract class LocationParser {
  final String name = "Location Parser";
  Future<List<LocationEntry>> format(String path);
}