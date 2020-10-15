import 'dart:convert';

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
            RaisedButton(
                child: Text("Load Social data"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilePickerScreen()),
                  );
                }
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
          child:
          Padding(
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
          )
      ),
    );
  }

  void openFilePicker(context) async {
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if(result != null) {
        PlatformFile file = result.files.first;

        String message_raw = await rootBundle.loadString(file.path);

        message_data_final = json.decode(message_raw);

        List<Widget> people = new List<Widget>();

        List people_all = new List();

        for(var i = 0; i < message_data_final.length; i++) {
          people_all.add(message_data_final[i]["person"]);
        }

        List people_unique = new List();

        for(var i = 0; i < people_all.length; i++) {
          if(!people_unique.contains(people_all[i])) {
            people_unique.add(people_all[i]);
          }
        }

        for(var i = 0; i < people_unique.length; i++) {
          people.add(new SizedBox(
            height:30,
            child:
            new Card(
                child:
                new Text(people_unique[i])
            ),
          ));
        }


        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DisplayInstagramStats(message_data: people),
            ));
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }
}

class DisplayInstagramStats extends StatelessWidget {
  List<Widget> message_data;

  DisplayInstagramStats({Key key, @required this.message_data}) : super(key: key);

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
              children: message_data
          )
      ),
    );
  }
}