class UniversalEntry {
  String type;
  String person;
  String source;
  DateTime time;
  String content;

  UniversalEntry(this.source, this.person, this.time, this.type,
      {this.content});

  UniversalEntry.fromJson(dynamic jsonObject) {
    type = jsonObject["type"];
    person = jsonObject["person"];
    source = jsonObject["source"];
    time = DateTime.parse(jsonObject["time"]);
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "person": person,
        "source": source,
        "time": time.toIso8601String()
      };
}
