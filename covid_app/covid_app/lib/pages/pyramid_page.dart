import 'package:covid_app/algo_result.dart';
import 'package:covid_app/pages/people_list_page.dart';
import 'package:flutter/material.dart';

class PyramidPage extends StatelessWidget {
  final List<AlgoResult> res;
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

  PyramidPage({this.res});

  void pyramidClick(BuildContext context, int layer) {
    List<AlgoResult> sliced = res.where((e) => e.level == layer).toList();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PeopleListPage(sliced, layerNames[layer], layerColors[layer], layerTextColors[layer]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    List numbers = [0, 0, 0, 0];

    for (AlgoResult score in res) {
      numbers[score.level] += 1;
    }

    String levelZeroFirstName = res.where((e) => e.level == 0).first.name;
    String levelOneFirstName = res.where((e) => e.level == 1).first.name;
    String levelTwoFirstName = res.where((e) => e.level == 2).first.name;
    String levelThreeFirstName = res.where((e) => e.level == 3).first.name;

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Ego Network"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Container(
              margin: const EdgeInsets.only(bottom: 20),
              width: 200,
              child: Text("Click on a level in your pyramid to see more",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Roboto", fontWeight: FontWeight.bold)),
            ),
            PyramidLayer(0, layerNames[0], levelZeroFirstName, numbers[0], 150, layerColors[0],
                pyramidClick),
            PyramidLayer(1, layerNames[1], levelOneFirstName, numbers[1], 250, layerColors[1],
                pyramidClick),
            PyramidLayer(2, layerNames[2], levelTwoFirstName, numbers[2], 300, layerColors[2],
                pyramidClick),
            PyramidLayer(3, layerNames[3], levelThreeFirstName, numbers[3], 350, layerColors[3],
                pyramidClick),
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
      child: FlatButton(
        color: accentColor,
        height: 50,
        minWidth: width,
        textColor: Colors.black,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        onPressed: () => onClick(context, this.level),
        child: Column(
          children: [
            Text(number.toString() + " " + title,
              style:
                TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.bold)),
            Text(friendName+" and others", style: TextStyle(fontSize: 12),)
          ],
        ),
      ),
    );
  }
}
