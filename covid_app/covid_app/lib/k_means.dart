import 'dart:math';
import 'package:flutter/foundation.dart';

List<int> kMeansCluster(int k, List<double> input, {int x = 100}) {
  Map<int, List<int>> results = Map<int, List<int>>();
  for (int i = 0; i < x; i++) {
    results[i] = doRun(k, input);
  }
  double minScore = double.maxFinite;
  int minScoreIndex = -1;
  for (int i = 0; i < x; i++) {
    double score = evaluateRun(k, input, results[i]);
    if (score < minScore) {
      minScore = score;
      minScoreIndex = i;
    }
    print(score);
  }
  return orderClusters(results[minScoreIndex]);
}

List<int> doRun(int k, List<double> input) {
  //Pick k random points
  double mini = input.reduce(min);
  double maxi = input.reduce(max);
  Random random = new Random();
  List<double> centroids = List<double>.generate(
      k, (i) => random.nextDouble() * (maxi - mini) + mini);
  //identify input points close to each point
  List<int> clusters = classifyClusters(input, centroids);
  List<int> oldClusters;
  do {
    //calculate mean of each cluster
    List<double> means = meanOfEachGroup(k, input, clusters);
    //redo identify step with mean instead of random
    centroids = means;
    oldClusters = List<int>.from(clusters);
    clusters = classifyClusters(input, centroids);
  } while (!listEquals(clusters, oldClusters));
  //repeat until no more change
  //sum variation in each cluster
  //repeat x times
  return clusters;
}

List<int> classifyClusters(List<double> input, List<double> centroids) =>
    List<int>.generate(input.length, (i) {
      double j = input[i];
      double minDist = double.maxFinite;
      int classification = -1;
      for (int k = 0; k < centroids.length; k++) {
        double cen = centroids[k];
        if ((cen - j).abs() < minDist) {
          minDist = (cen - j).abs();
          classification = k;
        }
      }
      return classification;
    });

double evaluateRun(int k, List<double> input, List<int> clusters) {
  List<double> means = meanOfEachGroup(k, input, clusters);
  List<double> squaredDif = List<double>.generate(input.length, (i) {
    return pow(input[i] - means[clusters[i]], 2);
  });
  var means2 = meanOfEachGroup(k, squaredDif, clusters);
  return means2.fold(0, (p, e) => p + e);
}

List<double> meanOfEachGroup(int k, List<double> input, List<int> clusters) {
  return List<double>.generate(k, (i) {
    List<int> indexsOfTypeI = [];
    for (int j = 0; j < clusters.length; j++) {
      if (clusters[j] == i) indexsOfTypeI.add(j);
    }
    List<double> values = List<double>.generate(
        indexsOfTypeI.length, (k) => input[indexsOfTypeI[k]]);
    return values.fold(0, (p, e) => p + e) / values.length;
  });
}

//So the list it generates is not in any order because init points are random;y
//generated. This just swaps ex) 2 2 3 3 1 -> 1 1 2 2 3
List<int> orderClusters(List<int> clusters) {
  if (clusters == null || clusters.length == 0) return List<int>();
  int last = -1;
  int counter = -1;
  return List<int>.generate(clusters.length, (i) {
    if (clusters[i] != last) counter++;
    last = clusters[i];
    return counter;
  });
}
