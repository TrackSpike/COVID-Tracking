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
          title: Text(title(helpIndex)),
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: FutureBuilder(
                  future: getContent(helpIndex),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return (snapshot.hasData)
                        ? Markdown(
                            data: snapshot.data,
                            physics: ClampingScrollPhysics(),
                          )
                        : Text("Loading...");
                  },
                ))));
  }
}

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
String title(index) {
  String title;

  if (index == 0) {
    title = 'Downloading Your Data';
  } else if (index == 1) {
    title = 'Uploading Your Data';
  } else if (index == 2) {
    title = 'Adjusting Your Algorithm Weights';
  } else if (index == 3) {
    title = 'Calculating Your Ego Network';
  } else if (index == 4) {
    title = 'Understanding Your Ego Network';
  } else if (index == 5) {
    title = 'More Information';
  } else {
    title = 'error: incorrect help index';
  }
  return title;
}

// No longer used, see files under assets/help/
// get the content of the page for the corresponding help page accessed
String content(index) {
  String content;

  if (index == 0) {
    content = 'To use this app you must first download your data from your '
        'Instagram and Snapchat accounts. This can be done using the links '
        'listed below.\n\n'
        '\u2022https://www.instagram.com/accounts/privacy_and_security/\n'
        '\u2022https://support.snapchat.com/en-US/a/download-my-data'
        '\n\nOnce you have downloaded your data you must '
        'upload the data to the device the app is installed on. To learn more '
        'about this go to the "Uploading Your Data" section in the Help tab.\n\n';
  } else if (index == 1) {
    content =
        'After you have downloaded your data, unzip the folder you downloaded. '
        'After you have unzipped the folder it is ready to be uploaded to your device. '
        'Simply upload it to any folder in the device but remember where you put it! '
        'Once uploaded link the data to the app by opening the app and going to '
        'the Upload Data tab. Link each data source by clicking the respective '
        'Upload button and navigating to the folder.'
        '\n\nNote: When linking the files, select the folder with the data'
        ' and then select "Use this folder". You do not have to dig further into '
        'the file structure.';
  } else if (index == 2) {
    content = 'If you wish to adjust the weights that the algorithm places on '
        'each type of communication that can be done through the Weights tab. '
        'Simply select the type of communication you wish to alter, drag the '
        'slider to your desired value and click the Save button. If you wish to '
        'reset to the default weights of the app you can use the button labeled '
        '"Reset Defaults" at the top of the screen. '
        '\n\nNote: After altering the weights you must Re-Calculate your Ego '
        'Network for your changes to take effect.';
  } else if (index == 3) {
    content = 'If you have downloaded and linked your data you are ready to '
        'calculate your Ego Network! Navigate to the Ego Network tab and click '
        'Calculate or Re-Calculate depending on if you have created your Ego Network '
        'before.';
  } else if (index == 4) {
    content = 'Once your Ego Network has been calculated it ranks your friends '
        'into broad categories. To see a detailed list of who is in each category '
        'select the category to inspect and then it will present you with a '
        'list of all the people in that category along with their calculated '
        'friendship level. The higher the friendship level the closer the '
        'friendship!';
  } else if (index == 5) {
    content = 'To get more information about our app visit our GitHub page!'
        '\n\nhttps://github.com/TrackSpike/COVID-Tracking';
  } else {
    content = 'error: incorrect help index';
  }
  return content;
}
