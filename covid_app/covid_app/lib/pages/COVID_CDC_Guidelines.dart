import 'package:flutter/material.dart';

class COVID_CDC_Guidelines extends StatefulWidget {
  COVID_CDC_Guidelines({Key key}) : super(key: key);

  @override
  _COVID_CDC_GuidelinesState createState() => _COVID_CDC_GuidelinesState();
}

class _COVID_CDC_GuidelinesState extends State<COVID_CDC_Guidelines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CDC Guidelines'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                  child: Text("Wash and Sanitize your Hands",
                      style: TextStyle(fontSize: 15))),
              Center(
                  child: Text("Stay Six feet from people outside your home",
                      style: TextStyle(fontSize: 15))),
              Center(
                  child: Text(
                      "Wear mask when in public places and avoid gatherings",
                      style: TextStyle(fontSize: 15))),
            ],
          ),
        ),
      ),
    );
  }
}
