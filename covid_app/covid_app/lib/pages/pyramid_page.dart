import 'package:covid_app/algo_result.dart';
import 'package:covid_app/pages/people_list_page.dart';
import 'package:flutter/material.dart';

class PyramidPage extends StatelessWidget {
  List<AlgoResult> res;
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

  PyramidPage({this.res});

  void pyramidClick(BuildContext context, int layer) {
    List<AlgoResult> sliced = res.where((e) => e.level == layer).toList();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PeopleListPage(sliced, layerNames[layer], layerColors[layer]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(res[0].level.toString());

    List numbers = [0, 0, 0, 0];

    for (AlgoResult score in res) {
      numbers[score.level] += 1;
    }

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
              child: Text("Click on a level in your pyramid to see more info",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Roboto", fontWeight: FontWeight.bold)),
            ),
            PyramidLayer(0, layerNames[0], numbers[0], 100, layerColors[0],
                pyramidClick),
            PyramidLayer(1, layerNames[1], numbers[1], 200, layerColors[1],
                pyramidClick),
            PyramidLayer(2, layerNames[2], numbers[2], 250, layerColors[2],
                pyramidClick),
            PyramidLayer(3, layerNames[3], numbers[3], 300, layerColors[3],
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
  final int number;
  final double width;
  final Color accentColor;
  final Function onClick;

  PyramidLayer(this.level, this.title, this.number, this.width,
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
        child: Text(number.toString() + " " + title,
            style:
                TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.bold)),
      ),
    );
  }
}
