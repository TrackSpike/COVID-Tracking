import 'dart:convert';
import 'dart:io';
import 'package:covid_app/pages/display_page.dart';
import 'package:covid_app/pages/home_page.dart';
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
            OutlineButton(
              onPressed: () {
                openFilePicker(context);
              },
              child: Text(uploadButton),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  void openFilePicker(context) async {
    try {
      String result = await FilePicker.platform.getDirectoryPath();
      InstagramParser parser = InstagramParser(result);
      Future<List> res = parser.format();
      //TODO: Append to lastUploadedData.json
      //writeFile(context, result);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  void writeFile(context, result) async {
    //Yes I know how dumb this is, its to make the future easier
    PlatformFile file = result.files.first;
    globals.uploadedFileName = result.files.first.name;
    String raw = await rootBundle.loadString(file.path);
    //This is where we will parse the data
    Directory directory = await getApplicationDocumentsDirectory();
    File fileNew = File("${directory.path}/lastUploadedData.json");
    await fileNew.writeAsString(raw);
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Success!"),
              content: Text("The data was loaded successfully."),
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
