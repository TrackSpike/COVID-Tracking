import 'package:flutter/material.dart';

class ScreenMore extends StatefulWidget {
  @override
  _ScreenMoreState createState() => _ScreenMoreState();
}

class _ScreenMoreState extends State<ScreenMore> {
  // Screen to display Text and Heading
  @override
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
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "If you confirmed positive Covid-19",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "1. Stay at home.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "2. stay in a specific room.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "3. Avoid sharing personal items with other people.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "4. Monitor your symptoms.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "5. Clean all surfaces.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "6. Get rest and stay hydrated.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "7. Cover your cough and sneezes.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "8. Wash your hands often.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "9. For medical emergencies, call 911.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
            ),
             
          ],
        ),
      ]),
    );
  }
}
