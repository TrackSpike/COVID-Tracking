import 'dart:convert';
import 'dart:io';
import 'package:covid_app/pages/display_page.dart';
import 'package:covid_app/pages/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        child: Column(
          children: [
            OutlineButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FilePickerScreen()),
                );
              },
              child: Text('Load Social Data'),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}

class FilePickerScreen extends StatelessWidget {
  String path;
  Map<String, String> paths;
  String extension;
  List message_data_final;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Data"),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Upload your messaging data'),
            RaisedButton(
              child: Text('Open File Picker'),
              onPressed: () {
                openFilePicker(context);
              },
            )
          ],
        ),
      )),
    );
  }

  void openFilePicker(context) async {
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      writeFile(context, result);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  void writeFile(context, result) async {
    //Yes I know how dumb this is, its to make the future easier
    PlatformFile file = result.files.first;
    String raw = await rootBundle.loadString(file.path);
    //This is where we will parse the data
    Directory directory = await getApplicationDocumentsDirectory();
    File fileNew = File('${directory.path}/lastUploadedData.json');
    await fileNew.writeAsString(raw);
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Success!"),
              content: Text('The data was loaded successfully.'),
              actions: <Widget>[
                TextButton(
                  child: Text('Nice!'),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                  },
                ),
              ],
        ));
  }
}

class DisplayInstagramStats extends StatelessWidget {
  final List<Widget> message_data;

  DisplayInstagramStats({Key key, @required this.message_data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Data"),
      ),
      body: Center(
          child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(15.0),
              children: message_data)),
    );
  }
}
