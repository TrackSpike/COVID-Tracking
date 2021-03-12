import 'package:covid_app/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/pages/help_page.dart';
import 'package:covid_app/pages/weights_page.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          SettingsToggleWidget("Presentation Mode", "presentationMode"),
          SettingsToggleWidget("Use Emotion NN", "useEmotionNn"),
          SettingsInputWidget("Exclude Name", "excludedName"),
          SettingsWidget(WeightsPage(), "Edit Weights", Icon(Icons.edit)),
          SettingsWidget(HelpPage(), "Help Page", Icon(Icons.help)),
        ],
      ),
    );
  }
}

class SettingsToggleWidget extends StatefulWidget {
  final String name;
  final String prefVariable;

  SettingsToggleWidget(this.name, this.prefVariable);

  @override
  State<StatefulWidget> createState() => _SettingsToggleState();
}

class _SettingsToggleState extends State<SettingsToggleWidget> {
  bool isOn = false;

  void initState() {
    super.initState();
    isOn = sharedPrefs.instance.getBool(widget.prefVariable) ?? false;
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

class SettingsInputWidget extends StatefulWidget {
  final String name;
  final String prefVariable;

  SettingsInputWidget(this.name, this.prefVariable);

  @override
  State<StatefulWidget> createState() => _SettingsInputWidgetState();
}

class _SettingsInputWidgetState extends State<SettingsInputWidget> {
  TextEditingController _controller = TextEditingController();

  void initState() {
    super.initState();
    _controller.text =
        sharedPrefs.instance.getString(widget.prefVariable) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.name),
        trailing: Container(
          width: 200,
          child: TextField(
            onChanged: (value) {
              sharedPrefs.instance.setString(widget.prefVariable, value);
            },
            controller: _controller,
            maxLines: 1,
          ),
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
