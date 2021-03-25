class LocationEntry {
  String source;
  String city;
  String region;
  String country;
  DateTime time;

  LocationEntry(this.source, this.city, this.region, this.country, this.time);

  LocationEntry.fromJson(dynamic jsonObject) {
    source = jsonObject["source"];
    city = jsonObject["city"];
    region = jsonObject["region"];
    country = jsonObject["country"];
    time = DateTime.parse(jsonObject["time"]);
  }

  Map<String, dynamic> toJson() => {
    "source": source,
    "city": city,
    "region": region,
    "country": country,
    "time": time.toIso8601String()
  };
}