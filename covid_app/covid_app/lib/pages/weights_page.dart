import 'dart:ui';

import 'package:flutter/material.dart';
import '../weights_handler.dart';

class WeightsPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final WeightsList weightsList = WeightsList();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RaisedButton(
                child: Text("Reset Defaults"),
                onPressed: () {
                  resetWeights();
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                }),
            Expanded(child: weightsList),
          ],
        ),
      ),
    );
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
                                alignment: Alignment.centerLeft,
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
                Text(
                    widget.weight.key,
                ),
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
              initialValue: widget.weight.value,
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
  final double initialValue;

  const ValuePickerDialog({Key key, this.initialValue}) : super(key: key);

  @override
  _ValuePickerDialogState createState() => _ValuePickerDialogState();
}

class _ValuePickerDialogState extends State<ValuePickerDialog> {
  /// current selection of the slider
  double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          "Edit Weight Value",
           textAlign: TextAlign.center,
      ),
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
