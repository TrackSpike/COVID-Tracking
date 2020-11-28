import 'package:flutter/material.dart';

import 'HomePage.dart';

// void main() {
//   runApp(MyApp());
// }

class MyAppSultan extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePageS(), // Main Screen of Covid-19 Tracker
    );
  }
}
