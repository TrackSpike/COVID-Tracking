import 'package:flutter/material.dart';
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
              title: Text('Downloading Your Data'),
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
              title: Text('Uploading Your Data'),
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
              title: Text('Adjusting Your Algorithm Weights'),
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

          Card(
            child: ListTile(
              leading: Icon(MdiIcons.accountGroupOutline),
              title: Text('Calculating Your Ego Network'),
              trailing: Icon(MdiIcons.currencyEth),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpContentPage(3),
                  )
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(MdiIcons.accountDetailsOutline),
              title: Text('Understanding Your Ego Network'),
              trailing: Icon(MdiIcons.currencyEth),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpContentPage(4),
                  )
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(MdiIcons.adjust),
              title: Text('More Information'),
              trailing: Icon(MdiIcons.currencyEth),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpContentPage(5),
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