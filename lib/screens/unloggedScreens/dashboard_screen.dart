import 'package:flutter/material.dart';
import 'package:new_solution/widgets/home1/navbar.dart';
import '../../widgets/dashboard/avatar_section.dart';
import '../../widgets/dashboard/actions_section.dart';
import '../../widgets/dashboard/stats_section.dart';
import '../../widgets/dashboard/quests_section.dart';
import '../../widgets/dashboard/weather_alerts.dart';
import '../../widgets/dashboard/roadmap_button.dart';
import '../../widgets/dashboard/missions_button.dart';
import '../../widgets/dashboard/leaderboard_button.dart';
import '../../widgets/chatbot_overlay.dart'; // Import chatbot overlay

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isChatOpen = false; // Track chatbot state

  void _toggleChat() {
    setState(() {
      _isChatOpen = !_isChatOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.lightBlue[50],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: NavBar(toggleChat: _toggleChat), // Pass toggleChat function
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = constraints.maxWidth;
              return screenWidth < 600
                  ? _buildMobileLayout()
                  : _buildTabletOrLargerLayout();
            },
          ),
        ),

        // Chatbot Overlay (conditionally visible)
        if (_isChatOpen)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FloatingActionButton(
              onPressed: () {
                ChatbotPopup.show(context);
              },
              child: Icon(Icons.chat),
            ),
          ),
      ],
    );
  }

  // 📱 Mobile Layout
  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarSection(),
          SizedBox(height: 10),
          RoadmapButton(),
          SizedBox(height: 10),
          MissionsButton(),
          SizedBox(height: 10),
          LeaderboardButton(),
          SizedBox(height: 20),
          WeatherAlerts(),
          SizedBox(height: 20),
          _buildHeader("Stats"),
          SizedBox(height: 10),
          StatsSection(),
          SizedBox(height: 20),
          _buildHeader("Daily Actions"),
          SizedBox(height: 10),
          _buildScrollContainer(ActionsSection()),
          SizedBox(height: 20),
          _buildHeader("Climate Quest"),
          SizedBox(height: 10),
          _buildScrollContainer(QuestsSection()),
        ],
      ),
    );
  }

  // 💻 Tablet & Larger Screens Layout
  Widget _buildTabletOrLargerLayout() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AvatarSection(),
                  SizedBox(height: 95),
                  RoadmapButton(),
                  SizedBox(height: 10),
                  MissionsButton(),
                  SizedBox(height: 10),
                  LeaderboardButton(),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  StatsSection(),
                  SizedBox(height: 10),
                  _buildHeader("Weather Alerts"),
                  SizedBox(height: 10),
                  WeatherAlerts(),
                ],
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeader("Daily Actions"),
                  SizedBox(height: 18),
                  ActionsSection(),
                  SizedBox(height: 18),
                  _buildHeader("Climate Quest"),
                  SizedBox(height: 18),
                  QuestsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.blue[700],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildScrollContainer(Widget child) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.purple, width: 0),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          )
        ],
      ),
      padding: EdgeInsets.all(10),
      child: child,
    );
  }
}
