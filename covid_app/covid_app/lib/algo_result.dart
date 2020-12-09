import 'dart:math';

bool presentatinMode = true;

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

  String getDisplayName() {
    if (presentatinMode) {
      Random rand = Random();
      return "User " + rand.nextInt(1000).toString();
    } else
      return name;
  }
}
