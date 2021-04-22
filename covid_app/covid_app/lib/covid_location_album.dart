import 'package:flutter/foundation.dart';

class CovidAlbum {
  final String date;
  final String county;
  final String state;
  final String country;
  final int newConfirmedCases;
  final int totalConfirmedCases;

  CovidAlbum({@required this.date, @required this.county, @required this.state, @required this.country, @required this.newConfirmedCases, @required this.totalConfirmedCases});

  factory CovidAlbum.fromJson(Map<String, dynamic> json) {
    return CovidAlbum(
      date: json['date'],
      county: json['subregion2_name'],
      state: json['subregion1_name'],
      country: json['country_name'],
      newConfirmedCases: json['new_confirmed'],
      totalConfirmedCases: json['total_confirmed']
    );
  }

}