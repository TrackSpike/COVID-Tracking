import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../weights_handler.dart';

class WeightsPage extends StatelessWidget {
  Widget build(BuildContext build) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
        title: Text(
          "Algo Weights",
        ),
      ),
      body: Center(
        child: WeightsList(),
      ),
    );
  }

  //Not quite done yet
  void resetDefaults() async {
    String weightString =
        await rootBundle.loadString('assets/algo_weights.json');
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/custom_weights.json');
    file.writeAsString(weightString);
  }
}

class WeightsList extends StatefulWidget {
  @override
  _WeightsListState createState() => _WeightsListState();
}

class _WeightsListState extends State<WeightsList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>>(
      future: getWeights(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, double>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text("Loading...");
          case ConnectionState.done:
            if (snapshot.data != null) {
              return Center(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                                width: double.maxFinite,
                                height: 75,
                                child: PersonDisplayWidget(
                                  WeightResult(
                                      snapshot.data.keys.elementAt(index),
                                      snapshot.data.values.elementAt(index)),
                                )),
                      ),
                    )
                  ],
                ),
              );
            }
            return Text("No data?");
          default:
            return Text("Error loading data");
        }
      },
    );
  }
}

class PersonDisplayWidget extends StatefulWidget {
  final WeightResult weight;

  PersonDisplayWidget(this.weight);

  @override
  _PersonDisplayWidgetState createState() => _PersonDisplayWidgetState();
}

class _PersonDisplayWidgetState extends State<PersonDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: double.maxFinite,
        child: GestureDetector(
          onTap: () => tapped(context),
          child: Card(
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(widget.weight.key),
                Text(
                  widget.weight.value.toStringAsFixed(2),
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ));
  }

  void tapped(BuildContext context) async {
    final selectedFontSize = await showDialog<double>(
        context: context,
        builder: (BuildContext context) => ValuePickerDialog(
              initalValue: 1,
            ));
    setState(() {
      widget.weight.value = selectedFontSize;
    });
    writeJson(widget.weight);
  }

  void writeJson(WeightResult result) async {
    Map<String, double> jsonResult = await getWeights();
    jsonResult[result.key] = result.value;
    writeWeights(jsonResult);
  }
}

class ValuePickerDialog extends StatefulWidget {
  /// initial selection for the slider
  final double initalValue;

  const ValuePickerDialog({Key key, this.initalValue}) : super(key: key);

  @override
  _ValuePickerDialogState createState() => _ValuePickerDialogState();
}

class _ValuePickerDialogState extends State<ValuePickerDialog> {
  /// current selection of the slider
  double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initalValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Weight Value"),
      content: Container(
        height: 100,
        child: Column(
          children: [
            Text("New Value: " + _value.toStringAsFixed(2)),
            Slider(
              value: _value,
              min: 0,
              max: 1,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            // Use the second argument of Navigator.pop(...) to pass
            // back a result to the page that opened the dialog
            Navigator.pop(context, _value);
          },
          child: Text("Save"),
        )
      ],
    );
  }
}

class WeightResult {
  String key;
  double value;
  WeightResult(this.key, this.value);
}
