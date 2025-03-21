import 'package:flutter/material.dart';
import '../screens/climate_screen.dart';
import '../screens/recommendations.dart';
import '../screens/carbon_screen.dart';
import '../screens/risk_alerts_screen.dart';

final List<List<dynamic>> featureList = [
  ["Carbon\nFootprint", Icons.calculate, CarbonScreen()],
  ["Climate\nStats", Icons.bar_chart, ClimateStatsScreen()],
  ["Recommendations", Icons.recommend, RecommendationsScreen()],
  ["Risk\nAlerts", Icons.warning, RiskAlertsScreen()],
];
