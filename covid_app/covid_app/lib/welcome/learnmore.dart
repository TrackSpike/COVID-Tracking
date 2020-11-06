import 'package:covid_app/welcome/screennext.dart';
import 'package:covid_app/welcome/screennextN.dart';
import 'package:flutter/material.dart';

class LearnMore extends StatefulWidget {
  @override
  _LearnMoreState createState() => _LearnMoreState();
}

class _LearnMoreState extends State<LearnMore> {
  @override
  // Screen to display user two option one for positive and one for negative result
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Color(0xFF114084),
        title: Center(
            child: Text(
          "Covid-19 Tracker",
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: ListView(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Color(0xFF3466AA),
              width: double.infinity,
              height: 320,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Stay Home Stay Safe",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 250,
                      child: Image.asset("assets/img.jpg"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                //color:Colors.blueGrey[100],
                //width:double.infinity,
                //height:double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "What would you have to do if your test is",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                color: Colors.red,
              ),
              width: double.infinity,
              height: 60,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ScreenMore())); // if user clicks at positive button it will move to display the ScreenMore  class which included title and text
                },
                child: Center(
                    child: Text(
                  "Positive",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                color: Colors.green,
              ),
              width: double.infinity,
              height: 60,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ScreenMoreN())); // if user clicks at negative  button it will move to display the ScreenMoreNegative  class which included title and text
                },
                child: Center(
                    child: Text(
                  "Negative",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                )),
              ),
            ),
          )
        ])
        //SizedBox(height: 20,),
      ]),
    );
  }
}
