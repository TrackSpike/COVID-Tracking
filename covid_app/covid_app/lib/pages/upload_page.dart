import 'dart:convert';
import 'dart:io';
import 'package:covid_app/pages/display_page.dart';
import 'package:covid_app/pages/home_page.dart';
import 'package:covid_app/parsers/parser.dart';
import 'package:covid_app/parsers/snapchat_parser.dart';
import 'package:covid_app/universal_entry.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:covid_app/parsers/instagram_parser.dart';
import 'package:covid_app/globals.dart' as globals;

class UploadPage extends StatefulWidget {
  UploadPage({Key key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    String dataSource = (globals.uploadedFileName != null)
        ? globals.uploadedFileName
        : "No data source";
    String uploadButton = (globals.uploadedFileName != null)
        ? "Overwrite Social Data"
        : "Load Social Data";
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Your Data"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Data Source: " + dataSource),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlineButton(
                  onPressed: () {
                    openFilePicker(context, InstagramParser());
                  },
                  child: Text("Upload Instagram"),
                ),
                OutlineButton(
                  onPressed: () {
                    openFilePicker(context, SnapchatParser());
                  },
                  child: Text("Upload Snapchat"),
                ),
              ],
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
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
    globals.uploadedFileName = pathResult;
    List<UniversalEntry> newEntries = await parser.format(pathResult);
    Directory directory = await getApplicationDocumentsDirectory();
    File dataFile = File("${directory.path}/lastUploadedData.json");
    List<UniversalEntry> entries =
        (json.decode(await dataFile.readAsString()) as List<dynamic>)
            .map((e) => UniversalEntry.fromJson(e))
            .toList();
    entries.addAll(newEntries);
    List<Map<String, dynamic>> entriesJson =
        entries.map((e) => e.toJson()).toList();
    await dataFile.writeAsString(json.encode(entriesJson));
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Success!"),
              content: Text("The ${parser.name} was added successfully."),
              actions: <Widget>[
                TextButton(
                  child: Text("Nice!"),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                  },
                ),
              ],
            ));
  }
}
