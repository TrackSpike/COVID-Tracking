import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:covid_app/location_entry.dart';
import 'package:covid_app/parsers/location_parsers/facebook_location_parser.dart';
import 'package:covid_app/parsers/location_parsers/location_parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

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
        title: Text('Location Data'), // The page title
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text("Work In Progress\n",
                  style: TextStyle(fontSize: 15))),
              Center(
                child: Text("Press a button to retrieve the corresponding location data\n",
                  style: TextStyle(fontSize: 15))),
              // Button that, when pressed, prompts the user to pick a file folder
              RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  openFilePicker(context, FacebookLocationParser());
                },
                child: Text("Facebook"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openFilePicker(context, LocationParser parser) async {
    try {
      String pathResult = await FilePicker.platform.getDirectoryPath();
      if (pathResult != null) //Null path is just canceled operation
        appendEntries(context, pathResult, parser);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  void appendEntries(context, String pathResult, LocationParser parser) async {
    List<LocationEntry> newEntries = await parser.format(pathResult);
    Directory directory = await getApplicationDocumentsDirectory();
    File dataFile = File("${directory.path}/lastUploadedLocationData.json");

    // If JSON file doesn't already exist, creates a new one and
    // populates it with empty data
    dataFile = await dataFile.create();
    List<Map<String, dynamic>> empty = [];
    dataFile.writeAsString(json.encode(empty));

    // Grabs existing entries from the JSON and adds them to the list
    List<LocationEntry> entries =
    (json.decode(await dataFile.readAsString()) as List<dynamic>)
        .map((e) => LocationEntry.fromJson(e))
        .toList();

    // Adds the new entries to the list
    entries.addAll(newEntries);

    //Big performance bottleneck
    //--------------------------------------------------------------------------
    List<Map<String, dynamic>> entriesJson =
    entries.map((e) => e.toJson()).toList();
    await dataFile.writeAsString(json.encode(entriesJson));
    //--------------------------------------------------------------------------
    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: Text("Success!"),
              content: Text("${parser.name} was retrieved successfully."),
              actions: <Widget>[
                RaisedButton(
                  child: Text("Nice!"),
                  onPressed: () {
                    //removes popup dialog box
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                  },
                ),
              ],
            ));
  }
}
