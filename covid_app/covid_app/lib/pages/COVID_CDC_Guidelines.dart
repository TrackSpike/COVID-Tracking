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
      ));
}
}
