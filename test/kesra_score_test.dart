import 'package:flutter_test/flutter_test.dart';
import 'package:kalory_help/providers/summary_provider.dart';
import 'package:kalory_help/providers/water_provider.dart';
import 'package:kalory_help/widgets/kesra_score.dart';

/// Helper that creates a SummaryProvider with test data.
SummaryProvider _makeSummary({
  int caloriesConsumed = 0,
  int caloriesGoal = 2000,
  int proteinConsumed = 0,
  int proteinGoal = 150,
  int carbsConsumed = 0,
  int carbsGoal = 250,
  int fatConsumed = 0,
  int fatGoal = 65,
}) {
  final s = SummaryProvider();
  s.setTestData(
    caloriesConsumed: caloriesConsumed,
    caloriesGoal: caloriesGoal,
    proteinConsumed: proteinConsumed,
    proteinGoal: proteinGoal,
    carbsConsumed: carbsConsumed,
    carbsGoal: carbsGoal,
    fatConsumed: fatConsumed,
    fatGoal: fatGoal,
  );
  return s;
}

/// Helper that creates a WaterProvider with test data.
WaterProvider _makeWater({int consumed = 0, int goal = 8}) {
  final w = WaterProvider();
  w.setTestData(consumed: consumed, goal: goal);
  return w;
}

void main() {
  group('KesraScore.computeScore', () {
    test('perfect adherence returns 100', () {
      final summary = _makeSummary(
        caloriesConsumed: 2000,
        caloriesGoal: 2000,
        proteinConsumed: 150,
        proteinGoal: 150,
        carbsConsumed: 250,
        carbsGoal: 250,
        fatConsumed: 65,
        fatGoal: 65,
      );
      final water = _makeWater(consumed: 8, goal: 8);

      final score = KesraScore.computeScore(summary, water);
      expect(score, 100);
    });

    test('zero consumption returns 0', () {
      final summary = _makeSummary();
      final water = _makeWater();

      final score = KesraScore.computeScore(summary, water);
      expect(score, 0);
    });

    test('score is between 0 and 100', () {
      final summary = _makeSummary(
        caloriesConsumed: 1500,
        caloriesGoal: 2000,
        proteinConsumed: 100,
        proteinGoal: 150,
        carbsConsumed: 200,
        carbsGoal: 250,
        fatConsumed: 50,
        fatGoal: 65,
      );
      final water = _makeWater(consumed: 5, goal: 8);

      final score = KesraScore.computeScore(summary, water);
      expect(score, greaterThanOrEqualTo(0));
      expect(score, lessThanOrEqualTo(100));
    });

    test('overconsumption penalizes the score', () {
      final exact = _makeSummary(
        caloriesConsumed: 2000,
        caloriesGoal: 2000,
        proteinConsumed: 150,
        proteinGoal: 150,
        carbsConsumed: 250,
        carbsGoal: 250,
        fatConsumed: 65,
        fatGoal: 65,
      );
      final over = _makeSummary(
        caloriesConsumed: 4000,
        caloriesGoal: 2000,
        proteinConsumed: 300,
        proteinGoal: 150,
        carbsConsumed: 500,
        carbsGoal: 250,
        fatConsumed: 130,
        fatGoal: 65,
      );
      final water = _makeWater(consumed: 8, goal: 8);

      expect(
        KesraScore.computeScore(exact, water),
        greaterThan(KesraScore.computeScore(over, water)),
      );
    });

    test('hydration contributes to score', () {
      final summary = _makeSummary(
        caloriesConsumed: 2000,
        caloriesGoal: 2000,
        proteinConsumed: 150,
        proteinGoal: 150,
        carbsConsumed: 250,
        carbsGoal: 250,
        fatConsumed: 65,
        fatGoal: 65,
      );
      final noWater = _makeWater(consumed: 0, goal: 8);
      final fullWater = _makeWater(consumed: 8, goal: 8);

      expect(
        KesraScore.computeScore(summary, fullWater),
        greaterThan(KesraScore.computeScore(summary, noWater)),
      );
    });

    test('half consumption gives roughly half score', () {
      final summary = _makeSummary(
        caloriesConsumed: 1000,
        caloriesGoal: 2000,
        proteinConsumed: 75,
        proteinGoal: 150,
        carbsConsumed: 125,
        carbsGoal: 250,
        fatConsumed: 33,
        fatGoal: 65,
      );
      final water = _makeWater(consumed: 4, goal: 8);

      final score = KesraScore.computeScore(summary, water);
      expect(score, greaterThan(30));
      expect(score, lessThan(70));
    });
  });
}
