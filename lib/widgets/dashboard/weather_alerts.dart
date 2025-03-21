import 'package:flutter/material.dart';
import 'package:new_solution/widgets/dashboard/components/alert_pop_up.dart';

class WeatherAlerts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth * 0.65;
        double sideBarWidth = maxWidth * 0.025;
        double paddingHorizontal = maxWidth * 0.05;

        return Column(
          children: [
            _buildScrollBar(),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxWidth.clamp(280, 600), // Min & max width
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFEF7EA),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.symmetric(
                      vertical: BorderSide(
                          color: Colors.lightBlue[50]!, width: sideBarWidth),
                    ),
                  ),
                  child: Stack(
                    children: [
                      _buildSideBar(left: true, width: sideBarWidth),
                      _buildSideBar(left: false, width: sideBarWidth),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: paddingHorizontal, vertical: 12),
                        child: SizedBox(
                          height: 250, // ✅ Scrollable area height
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                _buildAlert(context, Icons.warning,
                                    "Storm Alert!", Colors.red),
                                _buildAlert(context, Icons.cloud,
                                    "Rain Expected", Colors.blue),
                                _buildAlert(context, Icons.wb_sunny,
                                    "Heatwave Warning", Colors.orange),
                                _buildAlert(context, Icons.ac_unit,
                                    "Cold Wave Approaching", Colors.cyan),
                                _buildAlert(context, Icons.flood,
                                    "Flood Risk in Your Area", Colors.teal),
                                _buildAlert(context, Icons.waves,
                                    "High Tide Warning", Colors.indigo),
                                _buildAlert(context, Icons.bolt,
                                    "Thunderstorm Warning", Colors.yellow),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildScrollBar(),
          ],
        );
      },
    );
  }

  Widget _buildSideBar({required bool left, required double width}) {
    return Positioned(
      left: left ? -width / 2 : null,
      right: left ? null : -width / 2,
      top: 0,
      bottom: 0,
      width: width,
      child: Container(color: Color(0xFFD9B36E)),
    );
  }

  Widget _buildScrollBar() {
    return FractionallySizedBox(
      widthFactor: 0.75, // Adjust width dynamically
      child: Container(
        height: 20,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.45, 0.55],
            colors: [Color(0xFF9B6AFF), Color(0xFF4C21AA)],
          ),
        ),
      ),
    );
  }

// Inside _buildAlert function, wrap the container with GestureDetector
  Widget _buildAlert(
      BuildContext context, IconData icon, String title, Color iconColor) {
    return GestureDetector(
      onTap: () {
        AlertPopUp.show(context); // ✅ Call popup when tapped
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Color(0xFFF0EDE8),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(1, 2),
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: iconColor.withAlpha(200),
              radius: 16,
              child: Icon(icon, color: iconColor, size: 20),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(
                    "Stay updated on the latest weather conditions.",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            Text("9:41 AM",
                style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
