import 'package:flutter/material.dart';

class ScreenMoreN extends StatefulWidget {
  @override
  _ScreenMoreNState createState() => _ScreenMoreNState();
}

class _ScreenMoreNState extends State<ScreenMoreN> {
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
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Text(
                      "If you confirmed negative Covid-19",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "1. Clean your hands often. Use soap and water, or an alcohol-based hand rub",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "1. Clean your hands often. Use soap and water, or an alcohol-based hand rub",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "2. Maintain a safe distance from anyone who is coughing or sneezing.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "3. Wear a mask when physical distancing is not possible.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "4. Don’t touch your eyes, nose or mouth.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "5. Cover your nose and mouth with your bent elbow or a tissue when you cough or sneeze",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "6. Stay home if you feel unwell.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "7. If you have a fever, cough and difficulty breathing, seek medical attention.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
