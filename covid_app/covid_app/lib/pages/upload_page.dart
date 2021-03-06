import 'dart:convert';
import 'dart:io';
import 'package:covid_app/parsers/facebook_parser.dart';
import 'package:covid_app/parsers/parser.dart';
import 'package:covid_app/parsers/snapchat_parser.dart';
import 'package:covid_app/universal_entry.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:covid_app/parsers/instagram_parser.dart';

class UploadPage extends StatefulWidget {
  UploadPage({Key key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Your Data"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Data Sources", style: TextStyle(fontSize: 20)),
              DataSourceList(),
              RaisedButton(
                onPressed: () {
                  openFilePicker(context, InstagramParser());
                },
                child: Text("Upload Instagram"),
              ),
              RaisedButton(
                onPressed: () {
                  openFilePicker(context, SnapchatParser());
                },
                child: Text("Upload Snapchat"),
              ),
              RaisedButton(
                onPressed: () {
                  openFilePicker(context, FacebookParser());
                },
                child: Text("Upload Facebook"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openFilePicker(context, Parser parser) async {
    try {
      String pathResult = await FilePicker.platform.getDirectoryPath();
      if (pathResult != null) //Null path is just canceled operation
        appendEntries(context, pathResult, parser);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  void appendEntries(context, String pathResult, Parser parser) async {
    List<UniversalEntry> newEntries = await parser.format(pathResult);
    Directory directory = await getApplicationDocumentsDirectory();
    File dataFile = File("${directory.path}/lastUploadedData.json");
    if (!await dataFile.exists()) {
      dataFile = await dataFile.create();
      List<Map<String, dynamic>> empty = [];
      dataFile.writeAsString(json.encode(empty));
    }
    List<UniversalEntry> entries =
        (json.decode(await dataFile.readAsString()) as List<dynamic>)
            .map((e) => UniversalEntry.fromJson(e))
            .toList();
    entries.addAll(newEntries);
    //Big performance bottleneck
    //--------------------------------------------------------------------------
    List<Map<String, dynamic>> entriesJson =
        entries.map((e) => e.toJson()).toList();
    await dataFile.writeAsString(json.encode(entriesJson));
    //--------------------------------------------------------------------------
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Success!"),
              content: Text("${parser.name} was added successfully."),
              actions: <Widget>[
                RaisedButton(
                  child: Text("Nice!"),
                  onPressed: () {
                    //removes popup dialog box
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                    //navigates to ego network page, 0 is the page index it navigates to
                    DefaultTabController.of(context).animateTo(0);
                  },
                ),
              ],
            ));
  }
}

class DataSourceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: FutureBuilder<List<String>>(
        future: getUniqueSources(),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                height: 200, child: Center(child: Text("Loading...")));
          } else {
            return Container(
              height: 200,
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: (snapshot.data != null) ? snapshot.data.length : 0,
                  itemBuilder: (BuildContext context, int index) {
                    return DataSourceListEntry(snapshot.data[index]);
                  }),
            );
          }
        },
      ),
    );
  }

  Future<List<String>> getUniqueSources() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File dataFile = File("${directory.path}/lastUploadedData.json");
    if (!await dataFile.exists()) return [];
    List<UniversalEntry> entries =
        (json.decode(await dataFile.readAsString()) as List<dynamic>)
            .map((e) => UniversalEntry.fromJson(e))
            .toList();
    return entries.map((e) => e.source).toSet().toList();
  }
}

class DataSourceListEntry extends StatelessWidget {
  final String dataSource;
  DataSourceListEntry(this.dataSource);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(dataSource),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () => deleteSource(context, dataSource),
          )
        ],
      ),
    );
  }

  void deleteSource(context, String source) async {
    Directory directory = await getApplicationDocumentsDirectory();
    File dataFile = File("${directory.path}/lastUploadedData.json");
    List<UniversalEntry> entries =
        (json.decode(await dataFile.readAsString()) as List<dynamic>)
            .map((e) => UniversalEntry.fromJson(e))
            .toList();
    entries.removeWhere((UniversalEntry entry) => entry.source == source);
    List<Map<String, dynamic>> entriesJson =
        entries.map((e) => e.toJson()).toList();
    await dataFile.writeAsString(json.encode(entriesJson));
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Success!"),
              content: Text("$source was removed successfully."),
              actions: <Widget>[
                RaisedButton(
                  child: Text("Nice!"),
                  onPressed: () {
                    //removes popup dialog box
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                    //navigates to ego network page, 0 is the page index it navigates to
                    DefaultTabController.of(context).animateTo(0);
                  },
                ),
              ],
            ));
  }
}
