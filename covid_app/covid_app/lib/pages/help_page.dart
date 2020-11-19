import 'dart:convert';
import 'dart:io';
import 'package:covid_app/parsers/parser.dart';
import 'package:covid_app/parsers/snapchat_parser.dart';
import 'package:covid_app/universal_entry.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:covid_app/parsers/instagram_parser.dart';
import 'package:covid_app/globals.dart' as globals;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'help_content_page.dart';


class HelpPage extends StatefulWidget {
  HelpPage({Key key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help - Select a Tile to Learn More'),
      ),
      body: ListView(
        children: <Widget>[

          Card(
            child: ListTile(
              leading: Icon(MdiIcons.download),
              title: Text('How to Download Your Data'),
              trailing: Icon(MdiIcons.currencyEth),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpContentPage(0),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(MdiIcons.upload),
              title: Text('How to Upload Your Data'),
              trailing: Icon(MdiIcons.currencyEth),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpContentPage(1),
                  )
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(MdiIcons.accountCog),
              title: Text('Adjusting Your Weights'),
              trailing: Icon(MdiIcons.currencyEth),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpContentPage(2),
                  )
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}