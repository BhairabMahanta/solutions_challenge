import 'package:flutter/material.dart';
import '../providers/weather_provider.dart';

class WeatherInfoSection extends StatelessWidget {
  final Weather? weather;

  const WeatherInfoSection({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallScreen = screenWidth < 600; // Adaptive threshold

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 16),
      child: isSmallScreen
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildRecommendationCard(),
                const SizedBox(height: 10),
                _buildWeatherCard(isSmallScreen),
                const SizedBox(height: 10),
                _buildImpactCard(),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 4, child: _buildRecommendationCard()),
                const SizedBox(width: 12),
                _buildWeatherCard(isSmallScreen),
                const SizedBox(width: 12),
                Expanded(flex: 4, child: _buildImpactCard()),
              ],
            ),
    );
  }

  Widget _buildRecommendationCard() {
    return _buildInfoCard(
      titleRow: _buildTitleWithIcon(Icons.lightbulb, "Daily Recommendations"),
      contentWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTip(
              "⭐",
              "Perfect weather for air-drying clothes instead of using the dryer",
              Colors.green),
          _buildTip(
              "🚲", "Low traffic day - consider biking to work", Colors.blue),
          _buildTip("🌱", "Local farmers market today - reduce food miles",
              Colors.purple),
        ],
      ),
    );
  }

  Widget _buildWeatherCard(bool isSmallScreen) {
    return SizedBox(
      width: isSmallScreen ? double.infinity : 120, // Expand on small screens
      child: _buildInfoCard(
        titleRow: _buildTitleCentered(Icons.wb_sunny, "Weather"),
        content: weather != null ? "${weather!.temperature}°F" : "Loading...",
        isMiddle: true,
      ),
    );
  }

  Widget _buildImpactCard() {
    return _buildInfoCard(
      titleRow: _buildTitleWithIcon(Icons.eco, "Climate Impact Score: {x}"),
      content:
          "Your daily choices matter in the fight against climate change. Track your impact, stay informed, and make sustainable decisions that create a better future for all.",
    );
  }

  Widget _buildInfoCard({
    required Widget titleRow,
    String? content,
    Widget? contentWidget,
    bool isMiddle = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          titleRow,
          const SizedBox(height: 8),
          contentWidget ??
              Text(
                content ?? "",
                style: TextStyle(
                    fontSize: isMiddle ? 14 : 15, color: Colors.grey[700]),
                textAlign: isMiddle ? TextAlign.center : TextAlign.start,
              ),
        ],
      ),
    );
  }

  Widget _buildTitleWithIcon(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.blue), // Smaller for small screens
        const SizedBox(width: 6),
        Text(title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTitleCentered(IconData icon, String title) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.blue), // Adjusted icon size
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTip(String emoji, String text, Color bgColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87), // Smaller font for small screens
              ),
            ),
          ],
        ),
      ),
    );
  }
}
