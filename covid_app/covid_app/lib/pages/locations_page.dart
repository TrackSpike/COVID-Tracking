import 'package:flutter/material.dart';

class LocationsPage extends StatefulWidget {
  LocationsPage({Key key}) : super(key: key);

  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Data'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text("This is a blank screen",
                  style: TextStyle(fontSize: 15))),
              Center(
                child: Text("Hello",
                  style: TextStyle(fontSize: 15))),
            ],
          ),
        ),
      ),
    );
  }
}