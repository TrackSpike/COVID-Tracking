import 'package:flutter/material.dart';

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
        child: Text(content(helpIndex)),
      ),
    );
  }
}

// get the title of the page for the corresponding help page accessed
String title(index) {
  String title;
  if (index == 0) {
    title = 'zero';
  } else if (index == 1) {
    title = 'one';
  } else if (index == 2) {
    title = 'two';
  }
  return title;
}

// get the content of the page for the corresponding help page accessed
String content(index) {
  String content;
  if (index == 0) {
    content = 'zero';
  } else if (index == 1) {
    content = 'one';
  } else if (index == 2) {
    content = 'two';
  }
  return content;
}