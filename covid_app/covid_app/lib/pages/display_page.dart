import 'dart:io';
import 'dart:convert';
import 'package:covid_app/algo_result.dart';
import 'package:covid_app/pages/pyramid_page.dart';
import 'package:covid_app/pages/upload_page.dart';
import 'package:covid_app/pages/share_results.dart';
import 'package:covid_app/result_chart.dart';
import 'package:covid_app/universal_entry.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/algo.dart';
import 'package:path_provider/path_provider.dart';

class DisplayPage extends StatefulWidget {
  DisplayPage({Key key}) : super(key: key);

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  List<AlgoResult> algoData;

  @override
  void initState() {
    super.initState();
    setInitData();
  }

  void setInitData() async {
    var r = await getLastResult();
    setState(() {
      algoData = r;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Ego Network"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 25, 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FutureBuilder<List<AlgoResult>>(
                future: getLastResult(),
                builder: resultBuilder,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: calculateEgoNetwork,
                    child:
                        Text((algoData == null) ? "Calculate" : "Re-Calculate"),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text("Upload Data"),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UploadPage())),
                  ),
                  RaisedButton(
                      color: Colors.blue,
                      child: Text("Share Results"),
                      onPressed: () => {}),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget resultBuilder(
      BuildContext context, AsyncSnapshot<List<AlgoResult>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Text("Loading");
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.data != null)
        return ResultsDisplay(snapshot.data);
      else
        return Text("Hit Calculate to see results.");
    }
    return Text("Error");
  }

  void calculateEgoNetwork() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      File file = File('${directory.path}/lastUploadedData.json');
      String text = await file.readAsString();
      List<UniversalEntry> entries = (json.decode(text) as List<dynamic>)
          .map((e) => UniversalEntry.fromJson(e))
          .toList();
      List<AlgoResult> result = await calculate(entries);
      setState(() {
        algoData = result;
      });
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("Error"),
                content: Text(
                    "Your Ego network could not be calculated. Try uploading new data."),
                actions: <Widget>[
                  RaisedButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
    }
  }
}

// Basically a combo on the pyramid and new graph.
// Needed because the builder only returns one widget.
class ResultsDisplay extends StatelessWidget {
  final List<AlgoResult> results;

  ResultsDisplay(this.results);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          PyramidPage(res: results),
          ResultChart(results),
        ],
      )),
    );
  }
}
