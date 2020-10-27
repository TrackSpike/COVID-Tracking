import 'dart:io';
import 'dart:convert';
import 'package:covid_app/algo_result.dart';
import 'package:covid_app/universal_entry.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/algo.dart';
import 'package:path_provider/path_provider.dart';

class PyramidPage extends StatelessWidget {
  List<AlgoResult> res;

  PyramidPage({this.res});

  @override
  Widget build(BuildContext context) {
    debugPrint(res[0].level.toString());

    List numbers = [0, 0, 0, 0];

    for(AlgoResult score in res) {
      numbers[score.level-1] += 1;
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
              margin: const EdgeInsets.only(bottom:20),
              width: 200,
              child:
                Text(
                    "Click on a level in your pyramid to see more info",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold
                    )
                ),
            ),
            new Container(
                margin: const EdgeInsets.only(top: 10.0),
                child:FlatButton(
                  color: Colors.red,
                  height: 50,
                  minWidth: 100,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  splashColor: Colors.redAccent,
                  onPressed: () {
                    /*...*/
                  },
                  child: Text(
                      numbers[0].toString()+" Serious Friends",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
            ),
            new Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: FlatButton(
                  color: Colors.orange,
                  height: 50,
                  minWidth: 200,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  splashColor: Colors.orangeAccent,
                  onPressed: () {
                    /*...*/
                  },
                  child: Text(
                      numbers[1].toString()+" Good Friends",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
            ),
            new Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: FlatButton(
                  color: Colors.amber,
                  height: 50,
                  minWidth: 250,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  splashColor: Colors.amberAccent,
                  onPressed: () {
                    /*...*/
                  },
                  child: Text(
                      numbers[2].toString()+" Friends",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: FlatButton(
                color: Colors.yellow,
                height: 50,
                minWidth: 300,
                textColor: Colors.black,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                splashColor: Colors.yellowAccent,
                onPressed: () {
                  /*...*/
                },
                child: Text(
                  numbers[3].toString()+" Distant Friends",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
