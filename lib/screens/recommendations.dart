import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecommendationsScreen extends StatefulWidget {
  @override
  _RecommendationsScreenState createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  List<String> recommendations = [];

  @override
  void initState() {
    super.initState();
    fetchRecommendations();
  }

  Future<void> fetchRecommendations() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.example.com/personal-recommendations'), // Replace with real API
      );
      if (response.statusCode == 200) {
        setState(() {
          recommendations =
              List<String>.from(json.decode(response.body)["recommendations"]);
        });
      } else {
        setState(() {
          recommendations = ["Error fetching recommendations."];
        });
      }
    } catch (e) {
      setState(() {
        recommendations = ["An error occurred: $e"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SelectableText('Personalized Recommendations'),
        backgroundColor: Colors.green.shade700,
      ),
      body: recommendations.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: recommendations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.lightbulb),
                  title: SelectableText(recommendations[index]),
                );
              },
            ),
    );
  }
}
