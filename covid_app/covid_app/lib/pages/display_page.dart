import 'dart:io';
import 'dart:convert';
import 'package:covid_app/algo_result.dart';
import 'package:covid_app/pages/pyramid_page.dart';
import 'package:covid_app/universal_entry.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/algo.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';

class DisplayPage extends StatefulWidget {
  DisplayPage({Key key}) : super(key: key);

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Ego Network"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlineButton(
              onPressed: calculateEgoNetwork,
              child: Text('Calculate'),
            )
          ],
        ),
      ),
    );
  }

  void calculateEgoNetwork() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/lastUploadedData.json');
    String text = await file.readAsString();
    try {
      List<UniversalEntry> entries = (json.decode(text) as List<dynamic>)
          .map((e) => UniversalEntry.fromJson(e))
          .toList();
      List<AlgoResult> result = await calculate(entries);
      Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) => PyramidPage(res:result),
        fullscreenDialog: true,
      ));
    } catch(e) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Error"),
            content: Text('Your Ego network could not be calculated from the data loaded.'),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ));
    }
  }
}
