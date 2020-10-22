class UniversalEntry {
  String type;
  String person;
  String source;
  DateTime time;

  UniversalEntry(this.source, this.person, this.time, this.type);

  UniversalEntry.fromJson(dynamic jsonObject) {
    type = jsonObject['type'];
    person = jsonObject['person'];
    source = jsonObject['source'];
    time = DateTime.parse(jsonObject['time']);
  }
}
