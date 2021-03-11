import 'package:covid_app/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/pages/help_page.dart';
import 'package:covid_app/pages/weights_page.dart';
import 'package:vm_service/vm_service.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          SettingsToggleWiget("Presentation Mode", "presentationMode"),
          SettingsWidget(WeightsPage(), "Edit Weights", Icon(Icons.edit)),
          SettingsWidget(HelpPage(), "Help Page", Icon(Icons.help)),
        ],
      ),
    );
  }
}

class SettingsToggleWiget extends StatefulWidget {
  final String name;
  final String prefVariable;

  SettingsToggleWiget(this.name, this.prefVariable);

  @override
  State<StatefulWidget> createState() => _SettingsToggleWidget();
}

class _SettingsToggleWidget extends State<SettingsToggleWiget> {
  bool isOn = false;

  void initState() {
    super.initState();
    isOn = sharedPrefs.instance.getBool(widget.prefVariable);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.name),
        trailing: Switch(
          value: isOn,
          onChanged: (value) {
            setState(() => isOn = value);
            sharedPrefs.instance.setBool(widget.prefVariable, value);
          },
        ),
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
