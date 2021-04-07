import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class HelpContentPage extends StatelessWidget {
  final int helpIndex;

  HelpContentPage(this.helpIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(titles(helpIndex)),
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.only(left: 15, top: 15, right: 15),
                child: FutureBuilder(
                  future: getContent(helpIndex),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        return (snapshot.hasData)
                        ? Markdown(
                            data: snapshot.data,
                            physics: ClampingScrollPhysics(),
                            styleSheet: MarkdownStyleSheet(
                              h1: TextStyle(fontSize: 16),
                              h2: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                              h3: TextStyle(fontSize: 16)
                            ),
                          )
                        : Text("Loading...");
                  },
                )
            )
        )
    );
  }
}

// get the body content for the card
// to view or edit the body content go to the assets/help folder
Future<String> getContent(int index) async {
  List<String> names = [
    "downloading_your_data.md",
    "uploading_your_data.md",
    "changing_weights.md",
    "calculating_ego_network.md",
    "understanding_ego_network.md",
    "more_info.md"
  ];
  return rootBundle.loadString("assets/help/" + names[index]);
}

// get the title of the page for the corresponding help page accessed
String titles(index) {
  //list of titles corresponding to each index
  List<String> titles = [
    "Downloading Your Data",
    "Uploading Your Data",
    "Adjusting the Algorithm's Weights",
    "Calculating Your Ego Network",
    "Understanding Your Ego Network",
    "More Information",
    "error: incorrect help index"
  ];
  return titles[index];
}