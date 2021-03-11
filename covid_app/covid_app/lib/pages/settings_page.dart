import 'package:flutter/material.dart';
import 'package:covid_app/pages/help_page.dart';
import 'package:covid_app/pages/weights_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          SettingsWidget(WeightsPage(), "Edit Weights", Icon(Icons.edit)),
          SettingsWidget(HelpPage(), "Help Page", Icon(Icons.help)),
        ],
      ),
    );
  }
}

class SettingsWidget extends StatelessWidget {
  final Widget target;
  final String name;
  final Icon icon;

  SettingsWidget(this.target, this.name, this.icon);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: icon,
        title: Text(name),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => target),
          );
        },
      ),
    );
  }
}
