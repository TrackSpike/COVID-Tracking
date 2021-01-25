// Import the test package and Counter class
import 'package:covid_app/k_means.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Check for similar k-means results.", () {
    List<double> x = [4.0, 4.1, 4.2, -50, 200.2, 200.4, 200.9, 5, 100, 102];
    x.sort();
    int k = 4;
    expect(kMeansCluster(k, x), [0, 1, 1, 1, 1, 2, 2, 3, 3, 3]);
  });
}
