import 'package:flutter/material.dart';
import '../features/feature_button.dart';
import '../features/features.dart';

class FeatureGrid extends StatelessWidget {
  final Function(BuildContext, Widget) navigateTo;

  const FeatureGrid({Key? key, required this.navigateTo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int columnCount = screenWidth > 800
        ? 4
        : screenWidth > 500
            ? 3
            : 2; // Adjusts based on screen width

    double aspectRatio =
        screenWidth < 400 ? 1.4 : 1.8; // Adjusts for smaller screens

    return Container(
      padding: EdgeInsets.all(
          screenWidth < 400 ? 16 : 20), // Less padding on very small screens
      margin: const EdgeInsets.symmetric(horizontal: 16), // No change
      decoration: BoxDecoration(
        color: Color(0xFFFAF9F6),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Take Climate Action",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold), // Slightly smaller title
          ),
          const SizedBox(height: 4),
          const Text(
            "Explore tools and resources to understand your impact on the environment and take meaningful steps toward a sustainable future.",
            style: TextStyle(
                fontSize: 13, color: Colors.grey), // Reduced font size
          ),
          const SizedBox(height: 14),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: columnCount,
            crossAxisSpacing: screenWidth < 400
                ? 12
                : 16, // Smaller spacing for smaller screens
            mainAxisSpacing: screenWidth < 400 ? 12 : 16,
            childAspectRatio: aspectRatio,
            children: [
              _buildFeatureCard(context,
                  icon: Icons.directions_walk,
                  label: "Carbon Footprint",
                  screen: featureList[0][2] as Widget),
              _buildFeatureCard(context,
                  icon: Icons.show_chart,
                  label: "Climate Stats",
                  screen: featureList[1][2] as Widget),
              _buildFeatureCard(context,
                  icon: Icons.warning,
                  label: "Risk Alerts",
                  screen: featureList[2][2] as Widget),
              _buildFeatureCard(context,
                  icon: Icons.more_horiz,
                  label: "More Actions",
                  screen: featureList[3][2] as Widget),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context,
      {required IconData icon, required String label, required Widget screen}) {
    return Material(
      color: Color(0xFFFAF9F6),
      borderRadius: BorderRadius.circular(10), // Slightly smaller
      elevation: 3, // Reduced shadow depth
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          navigateTo(context, screen);
        },
        child: Container(
          padding: const EdgeInsets.all(14), // Smaller padding
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: Colors.blue), // Smaller icon
              const SizedBox(height: 6), // Less space
              Text(
                label,
                style: TextStyle(
                  fontSize: 13, // Smaller text
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
