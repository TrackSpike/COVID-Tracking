import 'package:covid_app/emotion_classifier/classifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  Classifier classifier = Classifier();
  List<String> positiveTerms = [
    "Thats great mark!!",
    "You're so amazing.",
    "You're the best!"
  ];
  List<String> negativeTerms = [
    "I hate you",
    "I never want to see you again... we're done",
    "You are a horrible person"
  ];
  testWidgets("Checking positive terms", (t) async {
    await Future.delayed(Duration(seconds: 1)); //Allow for init
    Map<String, bool> results = Map();
    for (String input in positiveTerms) {
      var result = classifier.classify(input);
      print(
          "$input : ${(result[0] * 100).toStringAsFixed(0)}% Neg  ${(result[1] * 100).toStringAsFixed(0)}% Pos");
      results[input] = result[1] > result[0];
    }
    expect(results.values.contains(false), true);
  });
  testWidgets("Checking negative terms", (t) async {
    await Future.delayed(Duration(seconds: 1)); //Allow for init
    Map<String, bool> results = Map();
    for (String input in negativeTerms) {
      var result = classifier.classify(input);
      print(
          "$input : ${(result[0] * 100).toStringAsFixed(0)}% Neg  ${(result[1] * 100).toStringAsFixed(0)}% Pos");
      results[input] = result[1] > result[0];
    }
    expect(results.values.contains(true), true);
  });
}
