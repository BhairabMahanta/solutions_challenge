import 'package:flutter/material.dart';
import 'package:new_solution/screens/carbon_screen.dart';
import 'package:new_solution/screens/unloggedScreens/community_screen.dart';
import 'package:new_solution/screens/unloggedScreens/dashboard_screen.dart';
import 'package:new_solution/widgets/carbon_calculator/carbon_quiz.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ClimateDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text("Climate Dashboard"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              spacing: 26,
              runSpacing: 16,
              children: [
                InfoCard(title: "50k+", subtitle: "Carbon Actions"),
                InfoCard(title: "100+", subtitle: "Business Partners"),
                InfoCard(title: "30%", subtitle: "Average Reduction"),
                InfoCard(title: "1M", subtitle: "Trees Planted"),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  FootprintCard(),
                  CommunityCard(),
                  ClimateScoreCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  InfoCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(subtitle,
              style: TextStyle(fontSize: 16, color: Colors.grey[700])),
        ],
      ),
    );
  }
}

class FootprintCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment(0.3, -1.2),
          end: Alignment(-0.4, 0.4),
          colors: [
            Color(0xFFFFF6F6),
            Color(0xFFFAEDED),
            Color(0xFFE6F4E0),
            Color(0xFFBAF9F6),
          ],
          stops: [0.26, 0.59, 0.75, 0.91],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset(6, 6),
            blurRadius: 12,
            spreadRadius: 3,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            offset: Offset(-3, -3),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// **Title + Footprint Icon + Update Button**
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.pets,
                      color: Colors.green, size: 22), // Footprint icon
                  SizedBox(width: 6),
                  Text(
                    "Your Weekly Footprint!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CarbonQuiz()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                      horizontal: 18, vertical: 12), // Increased padding
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold), // More readable
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 15, // Stronger shadow for 3D effect
                  shadowColor: Colors.black.withOpacity(0.3), // Smooth shadow
                ),
                child: Text("Update Footprint"),
              ),
            ],
          ),
          SizedBox(height: 8),

          /// **Main Value**
          Text(
            "2.568",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),

          /// **Comparison Row**
          Row(
            children: [
              Icon(Icons.arrow_downward, color: Colors.red, size: 16),
              Text(
                " 2.1% vs last week",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 10),

          /// **Date**
          Text(
            "Sales from 1-6 Dec, 2020",
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          SizedBox(height: 10),

          /// **Chart**
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <LineSeries<_ChartData, String>>[
                LineSeries<_ChartData, String>(
                  dataSource: [
                    _ChartData('01', 2.1),
                    _ChartData('02', 2.4),
                    _ChartData('03', 2.2),
                    _ChartData('04', 2.3),
                    _ChartData('05', 2.5),
                    _ChartData('06', 2.8),
                  ],
                  xValueMapper: (_ChartData data, _) => data.category,
                  yValueMapper: (_ChartData data, _) => data.value,
                  color: Colors.blue.shade300,
                  width: 2,
                ),
                LineSeries<_ChartData, String>(
                  dataSource: [
                    _ChartData('01', 2.0),
                    _ChartData('02', 2.3),
                    _ChartData('03', 2.1),
                    _ChartData('04', 2.4),
                    _ChartData('05', 2.3),
                    _ChartData('06', 2.6),
                  ],
                  xValueMapper: (_ChartData data, _) => data.category,
                  yValueMapper: (_ChartData data, _) => data.value,
                  color: Colors.purpleAccent.shade200,
                  width: 2,
                ),
              ],
            ),
          ),

          /// **Bottom Button**
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.9),
                foregroundColor: Colors.blue,
                elevation: 7,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              child: Text("View Report"),
            ),
          ),
        ],
      ),
    );
  }
}

/// **Data Model for Chart**

class _ChartData {
  final String category;
  final double value;
  _ChartData(this.category, this.value);
}

class CommunityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClimateCard(
      title: Row(
        children: [
          Icon(Icons.groups, size: 20, color: Colors.green),
          SizedBox(width: 6),
          Text(
            " Join Our Community!",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: SingleChildScrollView(
        // Enables scrolling if needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            _featureItem(Icons.person_add, "Connect with Like-Minded People"),
            _featureItem(Icons.chat_bubble, "Engage in Sustainability Talks"),
            _featureItem(
                Icons.emoji_events, "Compete on the Green Leaderboard"),
            _featureItem(Icons.menu_book, "Explore Eco-Friendly Guides"),
            _featureItem(Icons.forum, "Join Environmental Discussions"),
            _featureItem(Icons.lightbulb, "Discover Eco-Innovations"),
            SizedBox(height: 10), // Add spacing before button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CommunityScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 7,
                  backgroundColor: Colors.white,
                ),
                child:
                    Text("Explore Now!", style: TextStyle(color: Colors.blue)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 17),
          SizedBox(width: 6),
          Expanded(
            // Prevents overflow on small screens
            child: Text(text,
                style: TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

class ClimateScoreCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClimateCard(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(Icons.thermostat, size: 18, color: Colors.green),
                SizedBox(width: 6),
                Flexible(
                  child: Text(
                    "View Dashboard!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Flexible(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.9),
                foregroundColor: Colors.blueAccent,
                elevation: 7,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text("Dashboard", style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        // Enables scrolling
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeature(Icons.directions_run, "Track daily actions"),
                  _buildFeature(Icons.cloud, "Get weather alerts"),
                  _buildFeature(
                      Icons.assignment_turned_in, "Complete climate missions"),
                  _buildFeature(Icons.eco, "Adopt eco-friendly habits"),
                  _buildFeature(
                      Icons.leaderboard, "Compete on green leaderboard"),
                  _buildFeature(
                      Icons.volunteer_activism, "Join climate challenges"),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Climate Score",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        children: [
                          Container(
                            height: 12,
                            width: constraints.maxWidth,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          Container(
                            height: 12,
                            width: constraints.maxWidth * 0.74,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 4),
                  Text("74 / 100",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.blueAccent),
        SizedBox(width: 6),
        Expanded(
          child: Text(text,
              style: TextStyle(fontSize: 14), overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}

class ClimateCard extends StatelessWidget {
  final Widget title; // Change from String to Widget
  final Widget content;

  ClimateCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment(0.3, -1.2),
          end: Alignment(-0.4, 0.4),
          colors: [
            Color(0xFFFFF6F6),
            Color(0xFFFAEDED),
            Color(0xFFE6F4E0),
            Color(0xFFBAF9F6),
          ],
          stops: [0.26, 0.59, 0.75, 0.91],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset(6, 6),
            blurRadius: 12,
            spreadRadius: 3,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            offset: Offset(-3, -3),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title, // Now accepting a Widget instead of a String
            SizedBox(height: 10),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}
