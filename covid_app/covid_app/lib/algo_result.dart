class AlgoResult {
  String name;
  double score;
  int level;

  AlgoResult(this.name, this.score, this.level);

  Map<String, dynamic> toMap() {
    return {"name": name, "score": score, "level": level};
  }

  AlgoResult.fromJson(dynamic jsonObject) {
    name = jsonObject["name"];
    score = jsonObject["score"];
    level = jsonObject["level"];
  }
}
