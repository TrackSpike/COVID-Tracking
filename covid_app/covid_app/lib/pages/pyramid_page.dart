import 'package:covid_app/algo_result.dart';
import 'package:covid_app/pages/people_list_page.dart';
import 'package:flutter/material.dart';

final List<String> layerNames = [
  "Serious Friends",
  "Good Friends",
  "Friends",
  "Distant Friends"
];

final List<Color> layerColors = [
  Colors.redAccent,
  Colors.orangeAccent,
  Colors.amberAccent,
  Colors.yellowAccent
];

final List<Color> layerTextColors = [
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.black
];

class PyramidPage extends StatelessWidget {
  final List<AlgoResult> res;

  PyramidPage({this.res});

  void pyramidClick(BuildContext context, int layer) {
    List<AlgoResult> sliced = res.where((e) => e.level == layer).toList();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PeopleListPage(sliced, layerNames[layer],
              layerColors[layer], layerTextColors[layer]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    List numbers = [0, 0, 0, 0];

    for (AlgoResult score in res) {
      numbers[score.level] += 1;
    }

    var levelFirstNames = List(4);
    for (int i = 0; i < 4; i++) {
      try {
        levelFirstNames[i] =
            res.firstWhere((e) => e.level == i).getDisplayName();
      } catch (e) {
        levelFirstNames[i] = "";
      }
    }

    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              width: 200,
              child: Text("Click on a level in your pyramid to see more",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Roboto", fontWeight: FontWeight.bold)),
            ),
            PyramidLayer(0, layerNames[0], levelFirstNames[0], numbers[0], 200,
                layerColors[0], pyramidClick),
            PyramidLayer(1, layerNames[1], levelFirstNames[1], numbers[1], 250,
                layerColors[1], pyramidClick),
            PyramidLayer(2, layerNames[2], levelFirstNames[2], numbers[2], 300,
                layerColors[2], pyramidClick),
            PyramidLayer(3, layerNames[3], levelFirstNames[3], numbers[3], 350,
                layerColors[3], pyramidClick),
          ],
        ),
      ),
    );
  }
}

class PyramidLayer extends StatelessWidget {
  final int level;
  final String title;
  final String friendName;
  final int number;
  final double width;
  final Color accentColor;
  final Function onClick;

  PyramidLayer(this.level, this.title, this.friendName, this.number, this.width,
      this.accentColor, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      height: 55,
      width: width,
      child: RaisedButton(
          color: accentColor,
          textColor: Colors.black,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          onPressed: () => onClick(context, this.level),
          child: Column(children: [
            Text(number.toString() + " " + title,
                style: TextStyle(
                    fontFamily: "Roboto", fontWeight: FontWeight.bold)),
            Text((number > 1 ? "$friendName and others" : friendName),
                textAlign: TextAlign.center, style: TextStyle(fontSize: 12))
          ], mainAxisAlignment: MainAxisAlignment.center)),
    );
  }
}
